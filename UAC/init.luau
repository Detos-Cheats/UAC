local env = assert(getgenv, "UAC is not supported")

local function hasMethods(methods)
    for name in methods do
        if not env[name] then
            return false
        end
    end

    return true
end

local function useMethods(module)
    for name, method in module do
        if method then
            env[name] = method
        end
    end
end

local methods = {
    getgenv = getgenv,
    cloneref = cloneref,

    getconnections = getconnections or get_signal_cons,

    getrawmetatable = getrawmetatable,
    getgc = getgc or get_gc or get_gc_objects,
    getreg = getreg or getregistry or debug.getregistry,
    getupvalue = getupval or getupvalue or debug.getupvalue,
    setupvalue = setupval or setupvalue or debug.setupvalue,
    getupvalues = getupvals or getupvalues or debug.getupvalues,
    getconstants = getconsts or getconstants or debug.getconstants,

    iscclosure = iscclosure or is_c_closure,
    newcclosure = newcclosure or read_me or function(closure) return closure end,
    islclosure = islclosure or is_l_closure or (iscclosure and function(closure) return not iscclosure(closure) end),
    isourclosure = checkclosure or isourclosure or is_synapse_function or issentinelclosure or is_protosmasher_closure or is_sirhurt_closure or iselectronfunction or istempleclosure,

    hookmetamethod = hookmetamethod or (hookfunction and function(object, method, hook) return hookfunction(getrawmetatable(object)[method], hook) end),
    hookfunction = hookfunc or hookfunction or replaceclosure or hook_function or detour_function,

    checkcaller = checkcaller,
    isreadonly = isreadonly or table.isfrozen,
    getcallingscript = getcallingscript or get_calling_script,
}

env.hasMethods = hasMethods
env.UAC = {
    Methods = methods,
}

useMethods(env.UAC)