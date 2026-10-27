// script_7cfee4b69f710eed  (hash_7cfee4b69f710eed.gscc) (size: 3816 Bytes / 0xee8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a930b4e (1788021582)
// size ...... 3816 (0xee8)
// includes .. 2   (offset: 0xe08)
// strings ... 4   (offset: 0xe18)
// dev strs .. 6   (offset: 0xe94)
// exports ... 6   (offset: 0xa70)
// cseg ...... 0x77 + 0x9f9 (0xa70)
// imports ... 22  (offset: 0xb60)
// animtree1 . 0   (offset: 0xee8)
// animtree2 . 0   (offset: 0xee8)
#using script_24fb71c38c71fbe2;
#using scripts\common\ai_settings;

#namespace aitype;

// Namespace aitype
// Params 4
// Checksum 0xcdf5ae83, Offset: 0x95
// Size: 0x2c0
function main( aitype, aitypescriptbundle, selectedcharacter, weaponstruct )
{
    self.aitypeid = function_43b5ed5a14a56573( #"aitype", getxhashasset( aitype ) );
    
    if ( aitypescriptbundle.subclass != "" )
    {
        self.subclass_scriptbundle = getscriptbundle( hashcat( %"hash_138dab78b1b28a0f", aitypescriptbundle.subclass ) );
        self.subclass = self.subclass_scriptbundle.name;
    }
    
    if ( aitypescriptbundle.healthbarsettings != "" )
    {
        self.healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", aitypescriptbundle.healthbarsettings );
        healthbarbundle = getscriptbundle( aitypescriptbundle.healthbarsettings );
        
        if ( isdefined( healthbarbundle ) )
        {
            if ( healthbarbundle.supporthealthbar )
            {
                self.var_24954f14e27b448d = 1;
            }
            
            if ( healthbarbundle.supportnameplate )
            {
                self.var_80bfd8beda20e707 = 1;
            }
            
            if ( !healthbarbundle.hidedisplayname && healthbarbundle.randomdisplayname && healthbarbundle.displaynamelist.size > 0 )
            {
                self.nameindex = randomintrange( 1, healthbarbundle.displaynamelist.size );
            }
            
            self.var_6f21c22a420f0038 = healthbarbundle.var_6f21c22a420f0038;
        }
    }
    
    self.behaviortreeasset = getxhashasset( aitypescriptbundle.behaviortreeasset );
    
    if ( aitypescriptbundle.var_383c189719f73ccf != "" )
    {
        self.aishootstyle = aitypescriptbundle.var_383c189719f73ccf;
    }
    
    self.asmasset = aitypescriptbundle.animationstatemachine;
    
    if ( aitypescriptbundle.zombieaisetting != "" )
    {
        self.zombieaisetting = aitypescriptbundle.zombieaisetting;
    }
    
    assign_weapons( aitypescriptbundle, weaponstruct );
    
    if ( aitypescriptbundle.var_aab5beb67c1704ec )
    {
        self.var_aab5beb67c1704ec = 1;
        
        if ( isdefined( aitypescriptbundle.var_2a0bcfaae7400f6f ) && isdefined( aitypescriptbundle.var_959d9bf0d800e404 ) )
        {
            self.var_2a0bcfaae7400f6f = aitypescriptbundle.var_2a0bcfaae7400f6f;
            self.var_959d9bf0d800e404 = aitypescriptbundle.var_959d9bf0d800e404;
        }
    }
    
    assert( function_df63e3c9842e8497( selectedcharacter ), "<dev string:x24>" + ( isdefined( selectedcharacter ) ? getxhashsourcename( selectedcharacter ) : "<dev string:x6e>" ) + "<dev string:x78>" );
    self setcharacter( selectedcharacter );
    
    if ( aitypescriptbundle.aisettingsbundle != "" )
    {
        ai_settings::init_ai_settings( aitypescriptbundle.aisettingsbundle );
    }
}

// Namespace aitype
// Params 2
// Checksum 0xf4583da6, Offset: 0x35d
// Size: 0x1b5
function assign_weapons( aitypescriptbundle, weaponstruct )
{
    grenadeweaponhash = undefined;
    
    if ( aitypescriptbundle.grenadeweapon && aitypescriptbundle.grenadeweapon != "" )
    {
        grenadeweaponhash = getxhash( aitypescriptbundle.grenadeweapon );
    }
    
    if ( isdefined( grenadeweaponhash ) && isdefined( level.var_f01c6045bb80112f[ grenadeweaponhash ] ) )
    {
        self.grenadeweapon = level.var_f01c6045bb80112f[ grenadeweaponhash ];
        self.grenadeammo = aitypescriptbundle.grenadeammo;
    }
    else
    {
        self.grenadeweapon = nullweapon();
        self.grenadeammo = 0;
    }
    
    if ( isdefined( weaponstruct.primaryweaponhash ) && isdefined( level.var_f01c6045bb80112f[ weaponstruct.primaryweaponhash ] ) )
    {
        self.weapon = level.var_f01c6045bb80112f[ weaponstruct.primaryweaponhash ];
    }
    else
    {
        self.weapon = nullweapon();
    }
    
    if ( isdefined( weaponstruct.secondaryweaponhash ) && isdefined( level.var_f01c6045bb80112f[ weaponstruct.secondaryweaponhash ] ) )
    {
        self.secondaryweapon = level.var_f01c6045bb80112f[ weaponstruct.secondaryweaponhash ];
    }
    else
    {
        self.secondaryweapon = nullweapon();
    }
    
    if ( isdefined( weaponstruct.sidearmweaponhash ) && isdefined( level.var_f01c6045bb80112f[ weaponstruct.sidearmweaponhash ] ) )
    {
        self.sidearm = level.var_f01c6045bb80112f[ weaponstruct.sidearmweaponhash ];
        return;
    }
    
    self.sidearm = nullweapon();
}

// Namespace aitype
// Params 3
// Checksum 0x3e2dcf35, Offset: 0x51a
// Size: 0x23f
function precache( aitype, aitypescriptbundle, weaponstruct )
{
    foreach ( charactertype in aitypescriptbundle.charactertypes )
    {
        if ( charactertype.character == "" )
        {
            continue;
        }
        
        assert( function_df63e3c9842e8497( getxhashasset( charactertype.character ) ), "<dev string:x7b>" + charactertype.character + "<dev string:x78>" );
    }
    
    foreach ( characterlist in aitypescriptbundle.characterlists )
    {
        if ( characterlist.characterlistname == "" || !isdefined( characterlist.charactertypes ) )
        {
            continue;
        }
        
        foreach ( charactertype in characterlist.charactertypes )
        {
            if ( charactertype.character == "" )
            {
                continue;
            }
            
            assert( function_df63e3c9842e8497( getxhashasset( charactertype.character ) ), "<dev string:x7b>" + charactertype.character + "<dev string:x78>" );
        }
    }
    
    assets::setup_asset( aitypescriptbundle.unittype );
    thread setup_weapons( weaponstruct, aitypescriptbundle, aitype );
}

// Namespace aitype
// Params 6
// Checksum 0x87f76cfc, Offset: 0x761
// Size: 0x79, Type: bool
function validate_weapon( aitype, rootname, attachments, camo, reticle, variantid )
{
    /#
        if ( ![[ level.aivalidateweapon ]]( rootname, attachments, camo, reticle, variantid ) )
        {
            if ( !weaponexists( rootname ) )
            {
                assertmsg( "<dev string:xbf>" + aitype + "<dev string:xc8>" + rootname );
                return false;
            }
        }
    #/
    
    return true;
}

// Namespace aitype
// Params 3
// Checksum 0x710121d, Offset: 0x7e3
// Size: 0x28d
function setup_weapons( weaponstruct, aitypescriptbundle, aitype )
{
    if ( aitypescriptbundle.validmode != "SP" )
    {
        while ( !( isdefined( level.weaponmapdata ) && isdefined( level.aibuildweapon ) ) )
        {
            waitframe();
        }
    }
    
    if ( !isdefined( level.var_f01c6045bb80112f ) )
    {
        level.var_f01c6045bb80112f = [];
    }
    
    foreach ( weapon in weaponstruct.weaponlist )
    {
        if ( !isdefined( level.var_f01c6045bb80112f[ weapon.weaponhash ] ) )
        {
            if ( isdefined( weapon.attachments ) )
            {
                attachments = weapon.attachments;
            }
            else if ( aitypescriptbundle.validmode == "SP" )
            {
                attachments = [];
            }
            else
            {
                attachments = [ "none", "none", "none", "none", "none", "none" ];
            }
            
            if ( aitypescriptbundle.validmode == "SP" )
            {
                level.var_f01c6045bb80112f[ weapon.weaponhash ] = makeweapon( weapon.weaponname, attachments );
                continue;
            }
            
            if ( validate_weapon( aitype, weapon.weaponname, attachments, "camo_none", "none" ) )
            {
                level.var_f01c6045bb80112f[ weapon.weaponhash ] = [[ level.aibuildweapon ]]( weapon.weaponname, attachments, "camo_none", "none" );
            }
        }
    }
    
    if ( isdefined( aitypescriptbundle.grenadeweapon ) )
    {
        grenadeweaponhash = getxhash( aitypescriptbundle.grenadeweapon );
        
        if ( !isdefined( level.var_f01c6045bb80112f[ grenadeweaponhash ] ) )
        {
            defaultattachments = aitypescriptbundle.grenadeweapon == "" ? undefined : getweapondefaultattachments( aitypescriptbundle.grenadeweapon );
            level.var_f01c6045bb80112f[ grenadeweaponhash ] = makeweapon( aitypescriptbundle.grenadeweapon, defaultattachments );
        }
    }
}

