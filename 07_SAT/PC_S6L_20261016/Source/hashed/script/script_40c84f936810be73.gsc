// script_40c84f936810be73  (hash_40c84f936810be73.gscc) (size: 7386 Bytes / 0x1cda / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34831f64 (881008484)
// size ...... 7386 (0x1cda)
// includes .. 12  (offset: 0x1c02)
// strings ... 10  (offset: 0x1c62)
// dev strs .. 0   (offset: 0x1cda)
// exports ... 8   (offset: 0x11da)
// cseg ...... 0x26b + 0xf6f (0x11da)
// imports ... 74  (offset: 0x131a)
// animtree1 . 0   (offset: 0x1cda)
// animtree2 . 0   (offset: 0x1cda)
#using scripts\common\script;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent;
#using scripts\mp\pickups_scriptable;

#namespace namespace_e18d4996cbcfc831;

// Namespace namespace_e18d4996cbcfc831
// Params 0
// Checksum 0xc1167ad4, Offset: 0x289
// Size: 0xd6
function activate()
{
    var_f3d8401927b861dc = 120;
    
    for ( i = 0; i < 3 ; i++ )
    {
        spawnangle = var_f3d8401927b861dc * i + randomfloatrange( -15, 15 );
        spawnpos = level.player.origin + 75 * ( cos( spawnangle ), sin( spawnangle ), 0 );
        agent = mp_agent::spawnnewagentaitype( "support_mp_ar_base", spawnpos, ( 0, spawnangle, 0 ), level.player.team );
        agent.leader = level.player;
        agent.issupport = 1;
        agent thread function_bcd5072fbc478424();
        agent thread function_e1b715bba478682d();
    }
}

// Namespace namespace_e18d4996cbcfc831
// Params 0
// Checksum 0x8327b666, Offset: 0x367
// Size: 0xbb
function activate_enemy()
{
    var_f3d8401927b861dc = 360;
    enemyorigin = level.player.origin + anglestoforward( level.player.angles ) * 1000;
    
    for ( i = 0; i < 1 ; i++ )
    {
        spawnangle = var_f3d8401927b861dc * i + randomfloatrange( -15, 15 );
        spawnpos = enemyorigin + 75 * ( cos( spawnangle ), sin( spawnangle ), 0 );
        agent = mp_agent::spawnnewagentaitype( "enemy_mp_ar_base", spawnpos, ( 0, spawnangle, 0 ), "team_hundred_ninety_four" );
    }
}

// Namespace namespace_e18d4996cbcfc831
// Params 0
// Checksum 0xdca3aa82, Offset: 0x42a
// Size: 0x231
function function_bcd5072fbc478424()
{
    self endon( #"death" );
    self.leader endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self.leader waittill( #"hash_4c899cfd503a471b", notification, pingindex, var_fd2ae37400699499 );
        
        if ( !( isdefined( notification ) && isdefined( pingindex ) ) )
        {
            continue;
        }
        
        if ( notification == "calloutmarkerping_cleared" && isdefined( self.followingping ) && self.followingping == pingindex )
        {
            self notify( #"ping_canceled" );
            self.followingping = undefined;
            continue;
        }
        
        if ( notification == "calloutmarkerping_added" )
        {
            var_6675b0888e2dbc2 = self.leader function_689a4266a29aac13( pingindex );
            pingorigin = self.leader calloutmarkerping_getorigin( pingindex );
            
            if ( function_4c1b7cae739d9840( var_6675b0888e2dbc2 ) )
            {
                pingedscriptable = self.leader calloutmarkerping_getent( pingindex );
                
                if ( isdefined( pingedscriptable ) )
                {
                    self.followingping = pingindex;
                    self setgoalpos( getclosestpointonnavmesh( pingedscriptable.origin ) );
                }
            }
            else if ( calloutmarkerping::function_b658b8c35408496a( var_6675b0888e2dbc2 ) )
            {
                pingedent = self.leader calloutmarkerping_getent( pingindex );
                
                if ( isdefined( pingedent ) && isdefined( pingedent.entity ) )
                {
                    pingedent = pingedent.entity;
                }
                
                self.favoriteenemy = pingedent;
                self notify( #"target_switch" );
                thread function_ae849778a0fd4b66( pingedent );
            }
            else if ( function_4095a4f8e53eb368( var_6675b0888e2dbc2 ) )
            {
                pingedent = self.leader calloutmarkerping_getent( pingindex );
                
                if ( isdefined( pingedent ) && isdefined( pingedent.entity ) )
                {
                    pingedent = pingedent.entity;
                }
                
                self.followingping = pingindex;
                self setgoalpos( getclosestpointonnavmesh( pingedent.origin ) );
            }
            else if ( function_d929a855518b925a( var_6675b0888e2dbc2 ) || var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 6 ) )
            {
                self.followingping = pingindex;
                self setgoalpos( getclosestpointonnavmesh( pingorigin ) );
            }
            
            continue;
        }
    }
}

// Namespace namespace_e18d4996cbcfc831
// Params 0
// Checksum 0x186fff47, Offset: 0x663
// Size: 0xde
function function_e1b715bba478682d()
{
    self.leader endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self.leader waittill( #"damage", damage, attacker );
        
        if ( isdefined( self.favoriteenemy ) && self.leader.health >= 0.5 * self.leader.maxhealth )
        {
            continue;
        }
        
        if ( isalive( attacker ) && attacker.team != self.team )
        {
            if ( self.favoriteenemy == attacker )
            {
                continue;
            }
            
            self.favoriteenemy = attacker;
            self notify( #"target_switch" );
            thread function_ae849778a0fd4b66( attacker );
        }
    }
}

// Namespace namespace_e18d4996cbcfc831
// Params 1
// Checksum 0xb5d0abc3, Offset: 0x749
// Size: 0x45
function function_ae849778a0fd4b66( attacker )
{
    self endon( #"death" );
    self endon( #"target_switch" );
    
    while ( true )
    {
        attacker waittill( #"death" );
        self.favoriteenemy = undefined;
        return;
    }
}

// Namespace namespace_e18d4996cbcfc831
// Params 1
// Checksum 0x7aca9394, Offset: 0x796
// Size: 0x6fb
function function_d093ae34fac3da64( pickup )
{
    if ( br_public::isammo( pickup.scriptablename ) )
    {
        var_154443dbdffc0411 = br_pickups::canholdammobox( pickup.scriptablename );
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return br_pickups::function_bb73d66fb7091aaa( pickup, var_154443dbdffc0411 );
        }
        else if ( var_154443dbdffc0411 )
        {
            return 1;
        }
        else
        {
            return 4;
        }
    }
    
    isautouse = istrue( pickup.isautouse );
    
    if ( pickups::isweaponpickupitem( pickup ) )
    {
        if ( vehicle::is_in_vehicle() )
        {
            return 17;
        }
        
        newweapon = br_weapons::function_e21fbe40c5ae575e( pickup )[ 0 ];
        
        foreach ( weap in self.primaryweapons )
        {
            if ( issameweapon( weap, newweapon ) )
            {
                fakepickup = spawnstruct();
                fakepickup.scriptablename = br_weapons::br_ammo_type_for_weapon( newweapon );
                fakepickup.count = weaponclipsize( newweapon );
                
                if ( isdefined( fakepickup.scriptablename ) )
                {
                    result = br_pickups::function_bb73d66fb7091aaa( fakepickup, br_pickups::canholdammobox( pickup.scriptablename ) );
                    
                    if ( result == 1 )
                    {
                        result = 5;
                    }
                    else if ( result == 20 )
                    {
                        result = 27;
                    }
                    
                    return result;
                }
                
                return 28;
            }
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            script::demoforcesre( "shouldWeaponPickupGoToBackpack is deprecated. Add in common_inventory system logic instead." );
            lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
            result = common_inventory::function_e332683b9ad5368b( lootid, pickup.count );
            
            if ( result )
            {
                return 20;
            }
        }
        
        return 1;
    }
    
    if ( br_public::isequipment( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return br_pickups::function_3a6d2dc9abde2071( pickup, isautouse );
        }
        
        return 1;
    }
    
    if ( br_pickups::isplunder( pickup.scriptablename ) )
    {
        if ( isdefined( level.br_plunder ) && self.plundercount >= level.br_plunder.plunderlimit )
        {
            return 11;
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return br_pickups::function_3a6d2dc9abde2071( pickup, isautouse );
        }
    }
    
    if ( br_pickups::isgasmask( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return br_pickups::function_3a6d2dc9abde2071( pickup, isautouse );
        }
    }
    
    if ( br_pickups::function_56d8ca44f91af7c( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
            result = common_inventory::function_e332683b9ad5368b( lootid, pickup.count );
            
            if ( result )
            {
                return 20;
            }
        }
        
        return 1;
    }
    
    if ( br_pickups::iskillstreak( pickup.scriptablename ) )
    {
        killstreakref = level.br_pickups.br_lootreference[ pickup.scriptablename ];
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            script::demoforcesre( "shouldKillstreakGoToBackpack is deprecated. Add in common_inventory system logic instead." );
            lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
            result = common_inventory::function_e332683b9ad5368b( lootid, pickup.count );
            
            if ( result )
            {
                return 20;
            }
            
            lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
            result = common_inventory::function_e332683b9ad5368b( lootid, pickup.count );
        }
        
        return 4;
    }
    
    if ( br_pickups::issuperpickup( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            script::demoforcesre( "shouldFieldUpgradeGoToBackpack is deprecated. Add in common_inventory system logic instead." );
        }
        
        return 4;
    }
    
    if ( br_public::isarmor( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return br_pickups::function_dd4c2584cac2343e( pickup );
        }
        
        return 1;
    }
    
    if ( br_pickups::function_e380482ca8f0de4b( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            if ( !isdefined( pickup.count ) )
            {
                pickup.count = 1;
            }
            
            return br_pickups::function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( br_pickups::isaccesscard( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return br_pickups::function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( br_pickups::isattachment( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return br_pickups::function_3a6d2dc9abde2071( pickup );
        }
    }
    
    if ( br_pickups::iskey( pickup.scriptablename ) )
    {
        if ( br_pickups::function_ce9a9f8d70afdf01( pickup.scriptablename ) )
        {
            if ( self.var_30d27a6f168d83e1 )
            {
                return 23;
            }
            else
            {
                return 1;
            }
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
            script::demoforcesre( "getFirstAvailableStackableIndex is deprecated. Add in common_inventory system logic instead." );
            return br_pickups::function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( br_pickups::isvaluable( pickup.scriptablename ) || br_pickups::ispersonal( pickup.scriptablename ) || br_pickups::isnvg( pickup.scriptablename ) || br_pickups::isgascan( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return br_pickups::function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( br_pickups::isweaponcase( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return br_pickups::function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( br_public::function_d115f1547e28f0c6( pickup.scriptablename ) )
    {
        platelevel = br_public::function_f7d29d5dab587ae1( pickup.scriptablename );
        
        if ( self.platecarrierlevel < platelevel )
        {
            return 1;
        }
        
        return br_pickups::function_3a6d2dc9abde2071( pickup );
    }
    
    if ( br_pickups::isperkpack( pickup.scriptablename ) )
    {
        if ( isdefined( self.brperkpack ) && self.brperkpack != "brloot_perkpack_custom" && self.brperkpack == pickup.scriptablename )
        {
            if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
            {
                result = br_pickups::function_3a6d2dc9abde2071( pickup );
                
                if ( result == 4 )
                {
                    return 29;
                }
                else
                {
                    return result;
                }
            }
            else
            {
                return 4;
            }
        }
        
        return 1;
    }
    
    return 4;
}

// Namespace namespace_e18d4996cbcfc831
// Params 1
// Checksum 0x7297bfc3, Offset: 0xe9a
// Size: 0x340
function tryusescriptable( pingedscriptable )
{
    self endon( #"ping_canceled" );
    self waittill( #"goal" );
    isdoor = pingedscriptable scriptableisdoor();
    islootcache = pingedscriptable scriptableislootcache();
    isusable = pingedscriptable function_ef43fd0a946e1594();
    
    if ( isusable )
    {
        if ( isdoor )
        {
            if ( pingedscriptable scriptabledoorisclosed() )
            {
            }
            
            return;
        }
        
        if ( islootcache )
        {
            return;
        }
        
        part = pingedscriptable.type;
        state = pingedscriptable getscriptablepartstate( part );
        pickup = spawnstruct();
        pickup.scriptablename = pingedscriptable.type;
        pickup.origin = pingedscriptable.origin;
        pickup.count = common_item::function_44eacd480abb5b94( pingedscriptable.count );
        pickup.countlefthand = common_item::function_5c3ce1ec7db94488( pingedscriptable.count );
        pickup.countalt = common_item::function_3b2613fcafd07797( pingedscriptable.count );
        pickup.instance = pingedscriptable;
        pickup.customweaponname = pingedscriptable.customweaponname;
        pickup.maxcount = level.br_pickups.maxcounts[ pickup.scriptablename ];
        pickup.stackable = level.br_pickups.stackable[ pickup.scriptablename ];
        assert( isdefined( pickup.count ) );
        
        if ( !pickup.count && isdefined( level.br_pickups.counts[ pickup.scriptablename ] ) )
        {
            pickup.count = level.br_pickups.counts[ pickup.scriptablename ];
        }
        
        pickup.isweaponfromcrate = pingedscriptable.isweaponfromcrate;
        pickup.isautouse = 0;
        
        if ( !isdefined( pingedscriptable ) || pingedscriptable getscriptableisloot() && !br_pickups::lootusedignore( pingedscriptable ) )
        {
            results = function_d093ae34fac3da64( pickup );
            
            if ( results == 1 )
            {
                return br_pickups::function_f068be168c3a6776( pickup, self, 0, pingedscriptable );
            }
            
            if ( results == 20 )
            {
                return br_pickups::function_5cf1430d50947ac0( pickup, self, 0, pingedscriptable );
            }
            
            if ( results == 5 || results == 27 )
            {
                newweapon = br_weapons::function_e21fbe40c5ae575e( pickup )[ 0 ];
                fakepickup = spawnstruct();
                fakepickup.scriptablename = br_weapons::br_ammo_type_for_weapon( newweapon );
                fakepickup.origin = pickup.origin;
                fakepickup.count = weaponclipsize( newweapon );
                
                if ( results == 5 )
                {
                    br_pickups::function_f068be168c3a6776( fakepickup, self );
                }
                else
                {
                    br_pickups::function_5cf1430d50947ac0( fakepickup, self );
                }
                
                if ( isdefined( pingedscriptable ) )
                {
                    pickups::loothide( pingedscriptable );
                }
            }
        }
    }
}

