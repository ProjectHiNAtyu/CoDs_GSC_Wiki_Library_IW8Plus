// scripts\common\ai\aitypes\zombie_loom\zombie_loom_web_content.gsc  (hash_0caf88c4d4d9c8c3.gscc) (size: 11262 Bytes / 0x2bfe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1a5a47bf (442124223)
// size ...... 11262 (0x2bfe)
// includes .. 13  (offset: 0x29fa)
// strings ... 27  (offset: 0x2a62)
// dev strs .. 4   (offset: 0x2bce)
// exports ... 28  (offset: 0x1bea)
// cseg ...... 0x1d6 + 0x1a14 (0x1bea)
// imports ... 84  (offset: 0x204a)
// animtree1 . 0   (offset: 0x2bfe)
// animtree2 . 0   (offset: 0x2bfe)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\arsenal;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\crafting_table;
#using scripts\mp\interaction;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\perk_machines;

#namespace zombie_loom_web_content;

// Namespace zombie_loom_web_content
// Params 0
// Checksum 0xf5e4da0e, Offset: 0x1f4
// Size: 0x62
function init_global()
{
    /#
        function_16fd8ec16288553f();
    #/
    
    callback::get_template( self.animsetname ) callback::add( "out_playable_space", &out_playable_space );
    callback::get_template( self.animsetname ) callback::add( "in_playable_space", &in_playable_space );
    level callback::add( #"on_molotov_impact", &on_molotov_impact );
}

// Namespace zombie_loom_web_content
// Params 0
// Checksum 0xc40fea1, Offset: 0x25e
// Size: 0x19d
function init()
{
    self.var_69622555d714cbaf = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_37abd4f32ff35bc1 * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_37abd4f32ff35bc1;
    self.var_6fd7b2aa691cf55b = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6dea3e76f5b3e45a / 100;
    
    if ( !isdefined( self.var_b80666b93897c691 ) )
    {
        self.var_b80666b93897c691 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b80666b93897c691;
    }
    
    self.var_4623c359e48932b = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4623c359e48932b ) );
    
    if ( !isdefined( self.var_a2755b751509465a ) )
    {
        self.var_a2755b751509465a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a2755b751509465a;
    }
    
    if ( !isdefined( self.var_f25455524d1cc27b ) )
    {
        self.var_f25455524d1cc27b = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f25455524d1cc27b;
    }
    
    if ( !isdefined( self.var_8ecd18f1031f8fa9 ) )
    {
        self.var_8ecd18f1031f8fa9 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d484a895d442738f * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d484a895d442738f;
    }
    
    thread function_6d638f709dc95800();
    thread function_22b9668debfe7322();
    thread function_59cc3c30610b3f59();
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0xd12ee6c8, Offset: 0x403
// Size: 0x2c
function private function_ac399387a70d3830( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e )
    {
        self function_f2df0257c63f229( "disable_content_attack" );
        return;
    }
    
    self function_786bb6aa1b76c7ee( "disable_content_attack", 1 );
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0xdb3425f3, Offset: 0x437
// Size: 0x14
function private out_playable_space( params )
{
    function_ac399387a70d3830( 0 );
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0xf4a902a4, Offset: 0x453
// Size: 0x15
function private in_playable_space( params )
{
    function_ac399387a70d3830( 1 );
}

// Namespace zombie_loom_web_content
// Params 2
// Checksum 0xcc44f570, Offset: 0x470
// Size: 0x54
function function_aef6e1da208dab72( taskid, params )
{
    if ( self.var_e8402aef253302d6 && !self.contenttarget )
    {
        self.contenttarget = self.var_e8402aef253302d6;
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_loom_web_content
// Params 0, eflags: 0x4
// Checksum 0xe351cff8, Offset: 0x4cd
// Size: 0x28
function private function_6d638f709dc95800()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.var_e8402aef253302d6 = function_28ed7094f3f9e6b6();
        wait 1;
    }
}

// Namespace zombie_loom_web_content
// Params 0, eflags: 0x4
// Checksum 0x5c186f5d, Offset: 0x4fd
// Size: 0x8a
function private function_22b9668debfe7322()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_c442e37d7a0419a8" );
        dir = anglestoforward( self.angles );
        
        if ( self.contenttarget )
        {
            dir = self.contenttarget.machinescriptable.origin - self.origin;
        }
        
        self orientmode( "face direction", dir );
        asm::function_7256f5ba459c840b( "content_attack_in" );
    }
}

// Namespace zombie_loom_web_content
// Params 0, eflags: 0x4
// Checksum 0x2edf40f, Offset: 0x58f
// Size: 0x2a
function private function_59cc3c30610b3f59()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_1f8c3af015d89822" );
        function_5a48a73ee2c4ab48();
    }
}

// Namespace zombie_loom_web_content
// Params 0, eflags: 0x4
// Checksum 0x589e3e1e, Offset: 0x5c1
// Size: 0x109
function private function_5a48a73ee2c4ab48()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    startpos = self gettagorigin( "tag_spinneret", 1 ) ?? ( 0, 0, 0 );
    projectile = spawn( "script_model", startpos );
    projectile setmodel( self.var_80bdd5b7339864bd );
    projectile.owner = self;
    projectile utility::function_32b24db3127bff40( "spit", "aerial" );
    endpos = self.contenttarget.machinescriptable.origin;
    distance = distance( startpos, endpos );
    traveltime = distance / 700;
    projectile moveto( endpos, traveltime );
    utility::delaycall( traveltime, &function_62b9dcbb89405a2f, self.contenttarget );
    utility::delaycall( traveltime, &delete_projectile, projectile );
    self function_786bb6aa1b76c7ee( "content_attack_time", gettime() + self.var_4623c359e48932b );
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0xf059f8b6, Offset: 0x6d2
// Size: 0x41
function private delete_projectile( projectile )
{
    impactvfx = utility::getfx( "loom_cocoon_impact" );
    
    if ( impactvfx )
    {
        playfx( impactvfx, projectile.origin );
    }
    
    projectile delete();
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0x49ed7bd3, Offset: 0x71b
// Size: 0x7b
function private function_62b9dcbb89405a2f( contenttarget )
{
    if ( isalive( self ) )
    {
        if ( self )
        {
            self.contenttarget = undefined;
        }
        
        function_56f58f59817ab984( 1, contenttarget );
        contenttarget.machinescriptable.iswebbed = 1;
        self.var_865aafa52f1e6798 = 1;
        
        while ( contenttarget.machinescriptable.iswebbed )
        {
            wait 0.2;
        }
        
        function_56f58f59817ab984( 0, contenttarget );
    }
}

// Namespace zombie_loom_web_content
// Params 2, eflags: 0x4
// Checksum 0xe351b2ce, Offset: 0x79e
// Size: 0x418
function private function_56f58f59817ab984( enable, contentmachine )
{
    if ( enable )
    {
        if ( !isdefined( level.var_30412fa9d34816e6 ) )
        {
            level.var_30412fa9d34816e6 = [];
        }
        
        function_ffc7aa3d8bfaf332( contentmachine );
        contentmachine.machinescriptable.var_b80666b93897c691 = self.var_b80666b93897c691;
        contentmachine.machinescriptable.var_a2755b751509465a = self.var_a2755b751509465a;
        contentmachine.machinescriptable.var_f25455524d1cc27b = self.var_f25455524d1cc27b;
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( contentmachine.machinescriptable.origin ) );
        contentmachine.machinescriptable.var_2b5852f808241817 = self.var_6fd7b2aa691cf55b * zombie_base_health;
        contentmachine.machinescriptable.maxhealth = 100000000;
        contentmachine.machinescriptable.health = contentmachine.machinescriptable.maxhealth;
        contentmachine.team = self.team;
        damage_utility::register_damageable_entity( contentmachine.machinescriptable, contentmachine.team );
        contentmachine.machinescriptable utility::function_32b24db3127bff40( "webs", "webbed" );
        contentmachine.machinescriptable.var_b196c5e6da89bfe8 = ( 0, 0, 32 );
        
        if ( contentmachine.machinescriptable isscriptable() )
        {
            contentmachine.machinescriptable.var_1355a2eee0e45cf0 = 1;
            contentmachine.machinescriptable thread function_8bb6f91d3ae16419();
            contentmachine.machinescriptable setcandamage( 1 );
        }
        else if ( contentmachine.machinescriptable isscriptableinstance() )
        {
            contentmachine.machinescriptable.var_1355a2eee0e45cf0 = 1;
            contentmachine.machinescriptable.var_af70f02bb9462edd = 1;
            
            if ( !isdefined( contentmachine.machinescriptable.var_4f006656feac822d ) )
            {
                contentmachine.machinescriptable.var_4f006656feac822d = [];
            }
            
            contentmachine.machinescriptable.var_4f006656feac822d[ contentmachine.machinescriptable.var_4f006656feac822d.size ] = &function_9c626cc135abdefd;
        }
        
        function_cdd68400e0c06242( 1, contentmachine );
        contentmachine.machinescriptable thread function_91f9ab975bf0f360( self );
        level.var_30412fa9d34816e6[ level.var_30412fa9d34816e6.size ] = contentmachine;
        return;
    }
    
    contentmachine.machinescriptable utility::function_32b24db3127bff40( "webs", "clear" );
    
    if ( isdefined( contentmachine.machinescriptable ) && contentmachine.machinescriptable isscriptable() )
    {
        contentmachine.machinescriptable.var_1355a2eee0e45cf0 = 0;
        contentmachine.machinescriptable setcandamage( 0 );
    }
    else if ( isdefined( contentmachine.machinescriptable ) && contentmachine.machinescriptable isscriptableinstance() )
    {
        contentmachine.machinescriptable.var_1355a2eee0e45cf0 = 0;
        contentmachine.machinescriptable.var_4f006656feac822d = arrayremove( contentmachine.machinescriptable.var_4f006656feac822d, &function_9c626cc135abdefd );
        contentmachine.machinescriptable.var_af70f02bb9462edd = 0;
    }
    
    function_cdd68400e0c06242( 0, contentmachine );
    damage_utility::function_b84e11c8ca9801fe( contentmachine.machinescriptable, contentmachine.team );
    contentmachine.machinescriptable notify( #"hash_c1e30ee51a3e4128" );
    function_20c29e3f3f6d02e9( contentmachine );
    level.var_30412fa9d34816e6 = arrayremove( level.var_30412fa9d34816e6, contentmachine );
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0x2cb145d4, Offset: 0xbbe
// Size: 0xd3
function private function_ffc7aa3d8bfaf332( contentmachine )
{
    switch ( contentmachine.machinetype ?? -1 )
    {
        case 0:
            contentmachine.machinescriptable namespace_34fc1661493f2405::perk_machine_power_off( contentmachine.interact );
            break;
        case 1:
            crafting_table::function_6af83b4b84871d7e( contentmachine.machinestruct );
            contentmachine.interact setscriptablepartstate( "usable", "usable" );
            break;
        case 2:
            contentmachine.machinestruct arsenal::disable_arsenal( 1, 1 );
            contentmachine.interact arsenal::function_b89fcbc846cfa117( 1 );
            break;
        default:
            break;
    }
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0x189c0607, Offset: 0xc99
// Size: 0xb8
function private function_20c29e3f3f6d02e9( contentmachine )
{
    switch ( contentmachine.machinetype ?? -1 )
    {
        case 0:
            contentmachine.machinescriptable namespace_34fc1661493f2405::perk_machine_power_on( contentmachine.machinestruct.script_noteworthy, contentmachine.interact );
            break;
        case 1:
            crafting_table::function_6829250c1915a033( contentmachine.machinestruct );
            break;
        case 2:
            contentmachine.machinestruct arsenal::enable_arsenal( 1 );
            break;
        default:
            break;
    }
}

// Namespace zombie_loom_web_content
// Params 0, eflags: 0xc
// Checksum 0x3476a995, Offset: 0xd59
// Size: 0x27a
function private function_8bb6f91d3ae16419()
{
    self notify( #"hash_ca9fb313507c2739" );
    self endon( #"hash_ca9fb313507c2739" );
    self endon( #"hash_c1e30ee51a3e4128" );
    self.elementalweakness[ "fire" ] = 1;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( !isdefined( objweapon ) )
        {
            objweapon = level.weaponnone;
        }
        
        element = zombie_damage::get_element( objweapon, attacker, meansofdeath );
        dmgstruct = zombie_damage::build_damage_struct( inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, direction_vec, undefined, undefined, undefined, undefined, objweapon );
        dmgstruct.idamage = damage;
        override_damage = utility::callsharedfunc( #"hash_9f1fe2d32f2efa15", #"hash_46c84f4e79aa1b36", dmgstruct );
        var_1f9094aa868e0513 = dmgstruct.var_11e45b42fe0bdb00;
        
        if ( var_1f9094aa868e0513 )
        {
            damage = override_damage;
        }
        
        if ( !var_1f9094aa868e0513 )
        {
            dmgstruct.idamage = zombie_damage::function_881dfa87252ee0ea( dmgstruct );
            damage = zombie_damage::function_cef159ba09a96f98( dmgstruct );
            
            if ( !var_1f9094aa868e0513 && !isdefined( self.var_b80666b93897c691[ objweapon.var_25b0062cbe4d9c99 ] ) && element != "fire" && meansofdeath != "MOD_MELEE" )
            {
                damage *= self.var_f25455524d1cc27b;
            }
            
            if ( element == "fire" )
            {
                damage *= self.var_a2755b751509465a;
            }
        }
        
        self.var_2b5852f808241817 -= int( damage );
        var_c57ed7c52106c0f3 = 0;
        
        if ( self.var_2b5852f808241817 <= 0 )
        {
            var_c57ed7c52106c0f3 = 1;
        }
        
        if ( isplayer( attacker ) )
        {
            attacker namespace_9d8e359c3b1041e5::updatehitmarker_sharedfunc( "standard", var_c57ed7c52106c0f3 );
            
            if ( mp_agent_damage::function_e7d118eb7b017fa4() )
            {
                namespace_9d8e359c3b1041e5::displaydamagenumber_sharedfunc( attacker, self, "none", meansofdeath, objweapon, int( damage ), point, 0, element, 0, 0 );
            }
        }
        
        if ( var_c57ed7c52106c0f3 )
        {
            self.iswebbed = 0;
        }
    }
}

// Namespace zombie_loom_web_content
// Params 1
// Checksum 0x6d5fa43f, Offset: 0xfdb
// Size: 0x1c0
function function_9c626cc135abdefd( dmg_struct )
{
    self.elementalweakness[ "fire" ] = 1;
    meansofdeath = dmg_struct.smeansofdeath;
    damage = dmg_struct.idamage;
    attacker = dmg_struct.eattacker;
    objweapon = dmg_struct.objweapon;
    
    if ( !isdefined( objweapon ) )
    {
        objweapon = level.weaponnone;
    }
    
    element = zombie_damage::get_element( objweapon, attacker, meansofdeath );
    damage = dmg_struct.idamage;
    override_damage = utility::callsharedfunc( #"hash_9f1fe2d32f2efa15", #"hash_46c84f4e79aa1b36", dmg_struct );
    var_1f9094aa868e0513 = dmg_struct.var_11e45b42fe0bdb00;
    
    if ( var_1f9094aa868e0513 )
    {
        damage = override_damage;
    }
    
    if ( !var_1f9094aa868e0513 )
    {
        dmg_struct.idamage = zombie_damage::function_881dfa87252ee0ea( dmg_struct );
        damage = zombie_damage::function_cef159ba09a96f98( dmg_struct );
        
        if ( !var_1f9094aa868e0513 && !isdefined( self.var_b80666b93897c691[ objweapon.var_25b0062cbe4d9c99 ] ) && element != "fire" && meansofdeath != "MOD_MELEE" )
        {
            damage *= self.var_f25455524d1cc27b;
        }
        
        if ( element == "fire" )
        {
            damage *= self.var_a2755b751509465a;
        }
    }
    
    self.health = 100000000;
    self.var_2b5852f808241817 -= int( damage );
    var_c57ed7c52106c0f3 = 0;
    
    if ( self.var_2b5852f808241817 <= 0 )
    {
        var_c57ed7c52106c0f3 = 1;
    }
    
    if ( var_c57ed7c52106c0f3 )
    {
        self.iswebbed = 0;
    }
    
    return damage;
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0xc
// Checksum 0xa96d3c7d, Offset: 0x11a4
// Size: 0x9c
function private function_91f9ab975bf0f360( owner )
{
    self notify( #"hash_383b1628ecac3af6" );
    self endon( #"hash_383b1628ecac3af6" );
    self endon( #"hash_c1e30ee51a3e4128" );
    var_2ffc92cd0bdd7d8f = owner.var_8ecd18f1031f8fa9;
    owner waittill( #"death" );
    pos = owner.origin;
    
    if ( self.origin && pos && distancesquared( self.origin, pos ) < var_2ffc92cd0bdd7d8f )
    {
        self.iswebbed = 0;
    }
}

// Namespace zombie_loom_web_content
// Params 2, eflags: 0x4
// Checksum 0xd43b4063, Offset: 0x1248
// Size: 0x14f
function private function_cdd68400e0c06242( enable, contentmachine )
{
    if ( enable )
    {
        contentmachine.interact.owningscriptable = contentmachine.machinescriptable;
        contentmachine.interact.var_12632d3006d93a5d = contentmachine.interact.var_d8e3b07237845727;
        contentmachine.interact interaction::set_interact_use_callback( &function_45fb14254873925d );
        contentmachine.interact.interact_hint_callback_old = contentmachine.interact.interact_hint_callback;
        contentmachine.interact interaction::set_interact_hint_callback( &function_d4aefa974dd55727 );
        return;
    }
    
    contentmachine.interact interaction::function_f79442a47b0daabe( contentmachine.interact.var_12632d3006d93a5d );
    contentmachine.interact.var_12632d3006d93a5d = undefined;
    contentmachine.interact interaction::set_interact_hint_callback( contentmachine.interact.interact_hint_callback_old );
    contentmachine.interact.interact_hint_callback_old = undefined;
    contentmachine.interact.owningscriptable = undefined;
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0x255cb1ae, Offset: 0x139f
// Size: 0xc
function private function_45fb14254873925d( player )
{
    
}

// Namespace zombie_loom_web_content
// Params 2, eflags: 0x4
// Checksum 0x8fd1580, Offset: 0x13b4
// Size: 0x36
function private function_d4aefa974dd55727( usable, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zombie_loom_web_content
// Params 0, eflags: 0x4
// Checksum 0x287ac6e4, Offset: 0x13f3
// Size: 0x416
function private function_28ed7094f3f9e6b6()
{
    if ( !isdefined( level.var_41a11694190555a6 ) )
    {
        level.var_41a11694190555a6 = [];
        
        foreach ( perkmachine in level.a_s_perk_machines )
        {
            if ( perkmachine.mdl_perk_machine )
            {
                var_c310c68575d7ce40 = { #machinestruct:perkmachine, #interact:perkmachine.mdl_perk_machine.interact, #machinescriptable:perkmachine.mdl_perk_machine, #machinetype:0 };
                level.var_41a11694190555a6[ level.var_41a11694190555a6.size ] = var_c310c68575d7ce40;
                continue;
            }
            
            if ( perkmachine.is_wunderfizz )
            {
                level thread function_cfca140d31b920( perkmachine );
            }
        }
        
        foreach ( var_3af4366c7b0be84c in level.a_s_crafting_tables )
        {
            var_c310c68575d7ce40 = { #machinestruct:var_3af4366c7b0be84c, #interact:var_3af4366c7b0be84c.var_7fac639c5e7fd54.interact, #machinescriptable:var_3af4366c7b0be84c.var_7fac639c5e7fd54, #machinetype:1 };
            level.var_41a11694190555a6[ level.var_41a11694190555a6.size ] = var_c310c68575d7ce40;
        }
        
        foreach ( arsenal_location in level.var_52e94a468e66d601 )
        {
            var_c310c68575d7ce40 = { #machinestruct:arsenal_location, #interact:arsenal_location.mdl_arsenal.interact, #machinescriptable:arsenal_location.mdl_arsenal, #machinetype:2 };
            level.var_41a11694190555a6[ level.var_41a11694190555a6.size ] = var_c310c68575d7ce40;
        }
    }
    
    foreach ( var_75385495715741fb in level.var_41a11694190555a6 )
    {
        if ( var_75385495715741fb.machinescriptable.origin && self.origin && self.var_69622555d714cbaf > distancesquared( var_75385495715741fb.machinescriptable.origin, self.origin ) && !var_75385495715741fb.machinescriptable.iswebbed && is_machine_usable( var_75385495715741fb ) )
        {
            result = trace::ray_trace( self geteye(), var_75385495715741fb.machinescriptable.origin, self, undefined, undefined, undefined, 1 );
            
            if ( result[ "fraction" ] == 1 || result[ "scriptable" ] == var_75385495715741fb.machinescriptable || result[ "entity" ] == var_75385495715741fb.machinescriptable )
            {
                return var_75385495715741fb;
            }
        }
    }
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0x8fd81c34, Offset: 0x1812
// Size: 0x9c
function private function_cfca140d31b920( var_8da41c3c3720e8bb )
{
    self endon( #"game_ended" );
    
    while ( !isdefined( var_8da41c3c3720e8bb.mdl_perk_machine ) )
    {
        wait 4;
    }
    
    var_c310c68575d7ce40 = { #machinestruct:var_8da41c3c3720e8bb, #interact:var_8da41c3c3720e8bb.mdl_perk_machine.interact, #machinescriptable:var_8da41c3c3720e8bb.mdl_perk_machine, #machinetype:0 };
    level.var_41a11694190555a6[ level.var_41a11694190555a6.size ] = var_c310c68575d7ce40;
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0x44e73abd, Offset: 0x18b6
// Size: 0xc9
function private is_machine_usable( machine_info )
{
    switch ( machine_info.machinetype ?? -1 )
    {
        case 0:
            return ( machine_info.machinescriptable isscriptableinstance() && machine_info.machinescriptable getscriptablepartstate( "base" ) == "power_on" );
        case 1:
            return ( machine_info.machinescriptable isscriptable() && machine_info.machinescriptable getscriptablepartstate( "base" ) != "disabled" );
        case 2:
            return istrue( machine_info.machinestruct.var_5929513b9515fde7 );
        default:
            return 0;
    }
}

// Namespace zombie_loom_web_content
// Params 1, eflags: 0x4
// Checksum 0xfdddbab6, Offset: 0x1987
// Size: 0x20b
function private on_molotov_impact( params )
{
    radius = 40;
    
    if ( params.bundle.coredata.triggerradius && params.bundle.tendrildata.triggerradius )
    {
        radius = params.bundle.coredata.triggerradius + params.bundle.tendrildata.triggerradius;
    }
    
    radius += 64;
    radiussqrd = radius * radius;
    
    foreach ( webbed_machine in level.var_30412fa9d34816e6 )
    {
        if ( !webbed_machine.machinescriptable )
        {
            continue;
        }
        
        if ( distancesquared( params.grenade.origin, webbed_machine.machinescriptable.origin ) <= radiussqrd )
        {
            if ( utility::issharedfuncdefined( #"molotov", #"hash_42699d8a779042f6" ) )
            {
                webbed_machine.machinescriptable.var_68d56cb9e7f0999a = 1;
                webbed_machine.machinescriptable.var_3343534bd4a927d8 = 1;
                webbed_machine.machinescriptable thread [[ utility::getsharedfunc( #"molotov", #"hash_42699d8a779042f6" ) ]]( params.bundle.var_f81d0343e92b24c6 ?? 6, self, params.grenade, params.grenade );
            }
        }
    }
}

/#

    // Namespace zombie_loom_web_content
    // Params 0
    // Checksum 0x5535bcf2, Offset: 0x1b9a
    // Size: 0x2e, Type: dev
    function function_16fd8ec16288553f()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3a>", "<dev string:x55>", &function_f35ed347a303d49d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_loom_web_content
    // Params 0, eflags: 0x4
    // Checksum 0x4137b49e, Offset: 0x1bd0
    // Size: 0x1a, Type: dev
    function private function_f35ed347a303d49d()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x66>", @"hash_a45672b00cc5474b" );
    }

#/
