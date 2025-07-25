// IW9 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

free_expendable()
{
    if ( !isdefined( self.spawner ) || !isdefined( self.script_suspend ) )
        return;

    spawner = self.spawner;
    struct = spawnstruct();
    struct.origin = self.origin;
    struct.angles = self.angles;
    struct.suspendtime = gettime();

    if ( isdefined( self.suspendvars ) )
        struct.suspendvars = self.suspendvars;
    else
        struct.suspendvars = spawnstruct();

    if ( isdefined( self.stealth ) )
    {
        struct.stealth = spawnstruct();
        struct.stealth.bsmstate = self._id_FE5EBEFA740C7106;

        if ( isdefined( self._id_743F5EEB386835F5 ) )
            struct.stealth.investigateevent = self [[ self._id_743F5EEB386835F5 ]]();
    }

    if ( isdefined( self.node ) )
    {
        if ( isdefined( self.using_goto_node ) )
        {
            if ( isdefined( self.node.targetname ) )
                struct.target = self.node.targetname;

            struct.node = self.node;
        }

        struct.target = self.node.targetname;
    }

    spawner.suspended_ai = struct;

    if ( isdefined( self.script_suspend_group ) && !isdefined( self.script_free ) )
        free_groupname( self.script_suspend_group );
}

free_groupname( groupname )
{
    if ( !isdefined( level.processfreegroupname ) )
        level.processfreegroupname = [];

    if ( isdefined( level.processfreegroupname[groupname] ) )
        return;

    level.processfreegroupname[groupname] = 1;
    _id_DA96C8943126A950 = getaiarray();

    foreach ( ai in _id_DA96C8943126A950 )
    {
        if ( ai == self )
            continue;

        if ( !isdefined( ai.script_suspend_group ) )
            continue;

        if ( ai.script_suspend_group != groupname )
            continue;

        ai.script_free = 1;
        ai free_expendable();
        ai delete();
    }

    level.processfreegroupname[groupname] = undefined;
}

create_weapon_in_script( weaponarray, _id_E46130A1F1555462 )
{
    if ( !isdefined( level.fnscriptedweaponassignment ) )
    {
        self.usescriptedweapon = undefined;

        if ( !isdefined( weaponarray ) )
            weapon = nullweapon();
        else if ( !isarray( weaponarray ) && weaponarray == "" )
            weapon = nullweapon();
        else if ( isarray( weaponarray ) )
            weapon = makeweapon( weaponarray[randomint( weaponarray.size )] );
        else
            weapon = makeweapon( weaponarray );

        if ( !isnullweapon( weapon ) )
        {
            self.scriptedweaponfailed = 1;

            if ( isdefined( _id_E46130A1F1555462 ) && _id_E46130A1F1555462 == "sidearm" )
                self.scriptedweaponfailed_sidearmarray = weaponarray;
            else
                self.scriptedweaponfailed_primaryarray = weaponarray;
        }

        return weapon;
    }
    else
        return [[ level.fnscriptedweaponassignment ]]( weaponarray, _id_E46130A1F1555462 );
}

_id_3A249A1F1AECBB0E( _id_65769CBDBC09AD59, ai, param1, param2, param3, param4 )
{
    result = undefined;

    if ( isdefined( level.stealth._id_E376D807BB8CE93B ) )
        result = ai [[ level.stealth._id_E376D807BB8CE93B ]]( _id_65769CBDBC09AD59, param1, param2, param3, param4 );

    return istrue( result );
}

_id_9AEAD378CA03CB28( _id_77ED885C718B50AC, position, _id_93A30E5888017BAE )
{
    if ( isdefined( level._id_74E9C02B56E4BA52 ) )
        [[ level._id_74E9C02B56E4BA52 ]]( _id_77ED885C718B50AC, position, _id_93A30E5888017BAE );
}

_id_41FF5020F8762668( ent, _id_93A30E5888017BAE )
{
    if ( isdefined( level._id_8A42B71F799936AD ) )
        [[ level._id_8A42B71F799936AD ]]( ent, _id_93A30E5888017BAE );
}

_id_D5EE270AFC41E925( _id_93A30E5888017BAE )
{
    if ( isdefined( level._id_19EF4572543C12C1 ) )
        return [[ level._id_19EF4572543C12C1 ]]( _id_93A30E5888017BAE );

    return 1;
}

_id_8FF6B395C2615881( _id_65769CBDBC09AD59, requestid, data )
{
    if ( isdefined( level._id_03AE5F7DE11D142F ) )
        return [[ level._id_03AE5F7DE11D142F ]]( _id_65769CBDBC09AD59, requestid, data );
}

_id_2392636ED67E9FED()
{

}

_id_56543479237033C3()
{
    return ::_id_2392636ED67E9FED;
}
