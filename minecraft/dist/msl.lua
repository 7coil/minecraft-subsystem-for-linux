--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]

local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        ____moduleCache[file] = { value = (select("#", ...) > 0) and module(...) or module(file) }
        return ____moduleCache[file].value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["lualib_bundle"] = function(...) 
local function __TS__ArrayIsArray(value)
    return type(value) == "table" and (value[1] ~= nil or next(value) == nil)
end

local function __TS__ArrayConcat(self, ...)
    local items = {...}
    local result = {}
    local len = 0
    for i = 1, #self do
        len = len + 1
        result[len] = self[i]
    end
    for i = 1, #items do
        local item = items[i]
        if __TS__ArrayIsArray(item) then
            for j = 1, #item do
                len = len + 1
                result[len] = item[j]
            end
        else
            len = len + 1
            result[len] = item
        end
    end
    return result
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__ArrayEntries(array)
    local key = 0
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            local result = {done = array[key + 1] == nil, value = {key, array[key + 1]}}
            key = key + 1
            return result
        end
    }
end

local function __TS__ArrayEvery(self, callbackfn, thisArg)
    for i = 1, #self do
        if not callbackfn(thisArg, self[i], i - 1, self) then
            return false
        end
    end
    return true
end

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end

local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end

local function __TS__ArrayFind(self, predicate, thisArg)
    for i = 1, #self do
        local elem = self[i]
        if predicate(thisArg, elem, i - 1, self) then
            return elem
        end
    end
    return nil
end

local function __TS__ArrayFindIndex(self, callbackFn, thisArg)
    for i = 1, #self do
        if callbackFn(thisArg, self[i], i - 1, self) then
            return i - 1
        end
    end
    return -1
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local __TS__ArrayFrom
do
    local function arrayLikeStep(self, index)
        index = index + 1
        if index > self.length then
            return
        end
        return index, self[index]
    end
    local function arrayLikeIterator(arr)
        if type(arr.length) == "number" then
            return arrayLikeStep, arr, 0
        end
        return __TS__Iterator(arr)
    end
    function __TS__ArrayFrom(arrayLike, mapFn, thisArg)
        local result = {}
        if mapFn == nil then
            for ____, v in arrayLikeIterator(arrayLike) do
                result[#result + 1] = v
            end
        else
            for i, v in arrayLikeIterator(arrayLike) do
                result[#result + 1] = mapFn(thisArg, v, i - 1)
            end
        end
        return result
    end
end

local function __TS__ArrayIncludes(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    local k = fromIndex
    if fromIndex < 0 then
        k = len + fromIndex
    end
    if k < 0 then
        k = 0
    end
    for i = k + 1, len do
        if self[i] == searchElement then
            return true
        end
    end
    return false
end

local function __TS__ArrayIndexOf(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    if len == 0 then
        return -1
    end
    if fromIndex >= len then
        return -1
    end
    if fromIndex < 0 then
        fromIndex = len + fromIndex
        if fromIndex < 0 then
            fromIndex = 0
        end
    end
    for i = fromIndex + 1, len do
        if self[i] == searchElement then
            return i - 1
        end
    end
    return -1
end

local function __TS__ArrayJoin(self, separator)
    if separator == nil then
        separator = ","
    end
    local parts = {}
    for i = 1, #self do
        parts[i] = tostring(self[i])
    end
    return table.concat(parts, separator)
end

local function __TS__ArrayMap(self, callbackfn, thisArg)
    local result = {}
    for i = 1, #self do
        result[i] = callbackfn(thisArg, self[i], i - 1, self)
    end
    return result
end

local function __TS__ArrayPush(self, ...)
    local items = {...}
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__ArrayPushArray(self, items)
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__CountVarargs(...)
    return select("#", ...)
end

local function __TS__ArrayReduce(self, callbackFn, ...)
    local len = #self
    local k = 0
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[1]
        k = 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, len do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReduceRight(self, callbackFn, ...)
    local len = #self
    local k = len - 1
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[k + 1]
        k = k - 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, 1, -1 do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReverse(self)
    local i = 1
    local j = #self
    while i < j do
        local temp = self[j]
        self[j] = self[i]
        self[i] = temp
        i = i + 1
        j = j - 1
    end
    return self
end

local function __TS__ArrayUnshift(self, ...)
    local items = {...}
    local numItemsToInsert = #items
    if numItemsToInsert == 0 then
        return #self
    end
    for i = #self, 1, -1 do
        self[i + numItemsToInsert] = self[i]
    end
    for i = 1, numItemsToInsert do
        self[i] = items[i]
    end
    return #self
end

local function __TS__ArraySort(self, compareFn)
    if compareFn ~= nil then
        table.sort(
            self,
            function(a, b) return compareFn(nil, a, b) < 0 end
        )
    else
        table.sort(self)
    end
    return self
end

local function __TS__ArraySlice(self, first, last)
    local len = #self
    first = first or 0
    if first < 0 then
        first = len + first
        if first < 0 then
            first = 0
        end
    else
        if first > len then
            first = len
        end
    end
    last = last or len
    if last < 0 then
        last = len + last
        if last < 0 then
            last = 0
        end
    else
        if last > len then
            last = len
        end
    end
    local out = {}
    first = first + 1
    last = last + 1
    local n = 1
    while first < last do
        out[n] = self[first]
        first = first + 1
        n = n + 1
    end
    return out
end

local function __TS__ArraySome(self, callbackfn, thisArg)
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            return true
        end
    end
    return false
end

local function __TS__ArraySplice(self, ...)
    local args = {...}
    local len = #self
    local actualArgumentCount = __TS__CountVarargs(...)
    local start = args[1]
    local deleteCount = args[2]
    if start < 0 then
        start = len + start
        if start < 0 then
            start = 0
        end
    elseif start > len then
        start = len
    end
    local itemCount = actualArgumentCount - 2
    if itemCount < 0 then
        itemCount = 0
    end
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - start
    else
        actualDeleteCount = deleteCount or 0
        if actualDeleteCount < 0 then
            actualDeleteCount = 0
        end
        if actualDeleteCount > len - start then
            actualDeleteCount = len - start
        end
    end
    local out = {}
    for k = 1, actualDeleteCount do
        local from = start + k
        if self[from] ~= nil then
            out[k] = self[from]
        end
    end
    if itemCount < actualDeleteCount then
        for k = start + 1, len - actualDeleteCount do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
        for k = len - actualDeleteCount + itemCount + 1, len do
            self[k] = nil
        end
    elseif itemCount > actualDeleteCount then
        for k = len - actualDeleteCount, start + 1, -1 do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
    end
    local j = start + 1
    for i = 3, actualArgumentCount do
        self[j] = args[i]
        j = j + 1
    end
    for k = #self, len - actualDeleteCount + itemCount + 1, -1 do
        self[k] = nil
    end
    return out
end

local function __TS__ArrayToObject(self)
    local object = {}
    for i = 1, #self do
        object[i - 1] = self[i]
    end
    return object
end

local function __TS__ArrayFlat(self, depth)
    if depth == nil then
        depth = 1
    end
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = self[i]
        if depth > 0 and __TS__ArrayIsArray(value) then
            local toAdd
            if depth == 1 then
                toAdd = value
            else
                toAdd = __TS__ArrayFlat(value, depth - 1)
            end
            for j = 1, #toAdd do
                local val = toAdd[j]
                len = len + 1
                result[len] = val
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArrayFlatMap(self, callback, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = callback(thisArg, self[i], i - 1, self)
        if __TS__ArrayIsArray(value) then
            for j = 1, #value do
                len = len + 1
                result[len] = value[j]
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArraySetLength(self, length)
    if length < 0 or length ~= length or length == math.huge or math.floor(length) ~= length then
        error(
            "invalid array length: " .. tostring(length),
            0
        )
    end
    for i = length + 1, #self do
        self[i] = nil
    end
    return length
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local __TS__Unpack = table.unpack or unpack

local function __TS__FunctionBind(fn, ...)
    local boundArgs = {...}
    return function(____, ...)
        local args = {...}
        __TS__ArrayUnshift(
            args,
            __TS__Unpack(boundArgs)
        )
        return fn(__TS__Unpack(args))
    end
end

local __TS__Promise
do
    local function promiseDeferred(self)
        local resolve
        local reject
        local promise = __TS__New(
            __TS__Promise,
            function(____, res, rej)
                resolve = res
                reject = rej
            end
        )
        return {promise = promise, resolve = resolve, reject = reject}
    end
    local function isPromiseLike(self, thing)
        return __TS__InstanceOf(thing, __TS__Promise)
    end
    __TS__Promise = __TS__Class()
    __TS__Promise.name = "__TS__Promise"
    function __TS__Promise.prototype.____constructor(self, executor)
        self.state = 0
        self.fulfilledCallbacks = {}
        self.rejectedCallbacks = {}
        self.finallyCallbacks = {}
        do
            local function ____catch(e)
                self:reject(e)
            end
            local ____try, ____hasReturned = pcall(function()
                executor(
                    nil,
                    __TS__FunctionBind(self.resolve, self),
                    __TS__FunctionBind(self.reject, self)
                )
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
    end
    function __TS__Promise.resolve(data)
        local promise = __TS__New(
            __TS__Promise,
            function()
            end
        )
        promise.state = 1
        promise.value = data
        return promise
    end
    function __TS__Promise.reject(reason)
        local promise = __TS__New(
            __TS__Promise,
            function()
            end
        )
        promise.state = 2
        promise.rejectionReason = reason
        return promise
    end
    __TS__Promise.prototype["then"] = function(self, onFulfilled, onRejected)
        local ____promiseDeferred_result_0 = promiseDeferred(nil)
        local promise = ____promiseDeferred_result_0.promise
        local resolve = ____promiseDeferred_result_0.resolve
        local reject = ____promiseDeferred_result_0.reject
        local isFulfilled = self.state == 1
        local isRejected = self.state == 2
        if onFulfilled then
            local internalCallback = self:createPromiseResolvingCallback(onFulfilled, resolve, reject)
            local ____self_fulfilledCallbacks_1 = self.fulfilledCallbacks
            ____self_fulfilledCallbacks_1[#____self_fulfilledCallbacks_1 + 1] = internalCallback
            if isFulfilled then
                internalCallback(nil, self.value)
            end
        else
            local ____self_fulfilledCallbacks_2 = self.fulfilledCallbacks
            ____self_fulfilledCallbacks_2[#____self_fulfilledCallbacks_2 + 1] = function(____, v) return resolve(nil, v) end
        end
        if onRejected then
            local internalCallback = self:createPromiseResolvingCallback(onRejected, resolve, reject)
            local ____self_rejectedCallbacks_3 = self.rejectedCallbacks
            ____self_rejectedCallbacks_3[#____self_rejectedCallbacks_3 + 1] = internalCallback
            if isRejected then
                internalCallback(nil, self.rejectionReason)
            end
        else
            local ____self_rejectedCallbacks_4 = self.rejectedCallbacks
            ____self_rejectedCallbacks_4[#____self_rejectedCallbacks_4 + 1] = function(____, err) return reject(nil, err) end
        end
        if isFulfilled then
            resolve(nil, self.value)
        end
        if isRejected then
            reject(nil, self.rejectionReason)
        end
        return promise
    end
    function __TS__Promise.prototype.catch(self, onRejected)
        return self["then"](self, nil, onRejected)
    end
    function __TS__Promise.prototype.finally(self, onFinally)
        if onFinally then
            local ____self_finallyCallbacks_5 = self.finallyCallbacks
            ____self_finallyCallbacks_5[#____self_finallyCallbacks_5 + 1] = onFinally
            if self.state ~= 0 then
                onFinally(nil)
            end
        end
        return self
    end
    function __TS__Promise.prototype.resolve(self, data)
        if __TS__InstanceOf(data, __TS__Promise) then
            data["then"](
                data,
                function(____, v) return self:resolve(v) end,
                function(____, err) return self:reject(err) end
            )
            return
        end
        if self.state == 0 then
            self.state = 1
            self.value = data
            for ____, callback in ipairs(self.fulfilledCallbacks) do
                callback(nil, data)
            end
            for ____, callback in ipairs(self.finallyCallbacks) do
                callback(nil)
            end
        end
    end
    function __TS__Promise.prototype.reject(self, reason)
        if self.state == 0 then
            self.state = 2
            self.rejectionReason = reason
            for ____, callback in ipairs(self.rejectedCallbacks) do
                callback(nil, reason)
            end
            for ____, callback in ipairs(self.finallyCallbacks) do
                callback(nil)
            end
        end
    end
    function __TS__Promise.prototype.createPromiseResolvingCallback(self, f, resolve, reject)
        return function(____, value)
            do
                local function ____catch(e)
                    reject(nil, e)
                end
                local ____try, ____hasReturned = pcall(function()
                    self:handleCallbackData(
                        f(nil, value),
                        resolve,
                        reject
                    )
                end)
                if not ____try then
                    ____catch(____hasReturned)
                end
            end
        end
    end
    function __TS__Promise.prototype.handleCallbackData(self, data, resolve, reject)
        if isPromiseLike(nil, data) then
            local nextpromise = data
            if nextpromise.state == 1 then
                resolve(nil, nextpromise.value)
            elseif nextpromise.state == 2 then
                reject(nil, nextpromise.rejectionReason)
            else
                data["then"](data, resolve, reject)
            end
        else
            resolve(nil, data)
        end
    end
end

local function __TS__AsyncAwaiter(generator)
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            local adopt, fulfilled, step, resolved, asyncCoroutine
            function adopt(self, value)
                return __TS__InstanceOf(value, __TS__Promise) and value or __TS__Promise.resolve(value)
            end
            function fulfilled(self, value)
                local success, resultOrError = coroutine.resume(asyncCoroutine, value)
                if success then
                    step(nil, resultOrError)
                else
                    reject(nil, resultOrError)
                end
            end
            function step(self, result)
                if resolved then
                    return
                end
                if coroutine.status(asyncCoroutine) == "dead" then
                    resolve(nil, result)
                else
                    local ____self_0 = adopt(nil, result)
                    ____self_0["then"](____self_0, fulfilled, reject)
                end
            end
            resolved = false
            asyncCoroutine = coroutine.create(generator)
            local success, resultOrError = coroutine.resume(
                asyncCoroutine,
                function(____, v)
                    resolved = true
                    local ____self_1 = adopt(nil, v)
                    ____self_1["then"](____self_1, resolve, reject)
                end
            )
            if success then
                step(nil, resultOrError)
            else
                reject(nil, resultOrError)
            end
        end
    )
end
local function __TS__Await(thing)
    return coroutine.yield(thing)
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local function __TS__CloneDescriptor(____bindingPattern0)
    local value
    local writable
    local set
    local get
    local configurable
    local enumerable
    enumerable = ____bindingPattern0.enumerable
    configurable = ____bindingPattern0.configurable
    get = ____bindingPattern0.get
    set = ____bindingPattern0.set
    writable = ____bindingPattern0.writable
    value = ____bindingPattern0.value
    local descriptor = {enumerable = enumerable == true, configurable = configurable == true}
    local hasGetterOrSetter = get ~= nil or set ~= nil
    local hasValueOrWritableAttribute = writable ~= nil or value ~= nil
    if hasGetterOrSetter and hasValueOrWritableAttribute then
        error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
    end
    if get or set then
        descriptor.get = get
        descriptor.set = set
    else
        descriptor.value = value
        descriptor.writable = writable == true
    end
    return descriptor
end

local function __TS__ObjectAssign(target, ...)
    local sources = {...}
    for i = 1, #sources do
        local source = sources[i]
        for key in pairs(source) do
            target[key] = source[key]
        end
    end
    return target
end

local function __TS__ObjectGetOwnPropertyDescriptor(object, key)
    local metatable = getmetatable(object)
    if not metatable then
        return
    end
    if not rawget(metatable, "_descriptors") then
        return
    end
    return rawget(metatable, "_descriptors")[key]
end

local __TS__SetDescriptor
do
    local function descriptorIndex(self, key)
        local value = rawget(self, key)
        if value ~= nil then
            return value
        end
        local metatable = getmetatable(self)
        while metatable do
            local rawResult = rawget(metatable, key)
            if rawResult ~= nil then
                return rawResult
            end
            local descriptors = rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.get then
                        return descriptor.get(self)
                    end
                    return descriptor.value
                end
            end
            metatable = getmetatable(metatable)
        end
    end
    local function descriptorNewIndex(self, key, value)
        local metatable = getmetatable(self)
        while metatable do
            local descriptors = rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.set then
                        descriptor.set(self, value)
                    else
                        if descriptor.writable == false then
                            error(
                                ((("Cannot assign to read only property '" .. key) .. "' of object '") .. tostring(self)) .. "'",
                                0
                            )
                        end
                        descriptor.value = value
                    end
                    return
                end
            end
            metatable = getmetatable(metatable)
        end
        rawset(self, key, value)
    end
    function __TS__SetDescriptor(target, key, desc, isPrototype)
        if isPrototype == nil then
            isPrototype = false
        end
        local ____isPrototype_0
        if isPrototype then
            ____isPrototype_0 = target
        else
            ____isPrototype_0 = getmetatable(target)
        end
        local metatable = ____isPrototype_0
        if not metatable then
            metatable = {}
            setmetatable(target, metatable)
        end
        local value = rawget(target, key)
        if value ~= nil then
            rawset(target, key, nil)
        end
        if not rawget(metatable, "_descriptors") then
            metatable._descriptors = {}
        end
        metatable._descriptors[key] = __TS__CloneDescriptor(desc)
        metatable.__index = descriptorIndex
        metatable.__newindex = descriptorNewIndex
    end
end

local function __TS__Decorate(decorators, target, key, desc)
    local result = target
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator ~= nil then
                local oldResult = result
                if key == nil then
                    result = decorator(nil, result)
                elseif desc == true then
                    local value = rawget(target, key)
                    local descriptor = __TS__ObjectGetOwnPropertyDescriptor(target, key) or ({configurable = true, writable = true, value = value})
                    local desc = decorator(nil, target, key, descriptor) or descriptor
                    local isSimpleValue = desc.configurable == true and desc.writable == true and not desc.get and not desc.set
                    if isSimpleValue then
                        rawset(target, key, desc.value)
                    else
                        __TS__SetDescriptor(
                            target,
                            key,
                            __TS__ObjectAssign({}, descriptor, desc)
                        )
                    end
                elseif desc == false then
                    result = decorator(nil, target, key, desc)
                else
                    result = decorator(nil, target, key)
                end
                result = result or oldResult
            end
            i = i - 1
        end
    end
    return result
end

local function __TS__DecorateParam(paramIndex, decorator)
    return function(____, target, key) return decorator(nil, target, key, paramIndex) end
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0") or _VERSION == "Lua 5.1"
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (description .. "\n") .. tostring(self.stack)
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_1 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, self.constructor.new)
        local metatable = getmetatable(self)
        if metatable and not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
    end
    Error = ____initErrorClass_1(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_3 = initErrorClass
        local ____class_2 = __TS__Class()
        ____class_2.name = ____class_2.name
        __TS__ClassExtends(____class_2, Error)
        function ____class_2.prototype.____constructor(self, ...)
            ____class_2.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_3(nil, ____class_2, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
end

local function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

local function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                __TS__New(
                    TypeError,
                    ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. "."
                ),
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    target[key] = nil
    return true
end

local function __TS__StringAccess(self, index)
    if index >= 0 and index < #self then
        return string.sub(self, index + 1, index + 1)
    end
end

local function __TS__DelegatedYield(iterable)
    if type(iterable) == "string" then
        for index = 0, #iterable - 1 do
            coroutine.yield(__TS__StringAccess(iterable, index))
        end
    elseif iterable.____coroutine ~= nil then
        local co = iterable.____coroutine
        while true do
            local status, value = coroutine.resume(co)
            if not status then
                error(value, 0)
            end
            if coroutine.status(co) == "dead" then
                return value
            else
                coroutine.yield(value)
            end
        end
    elseif iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                return result.value
            else
                coroutine.yield(result.value)
            end
        end
    else
        for ____, value in ipairs(iterable) do
            coroutine.yield(value)
        end
    end
end

local __TS__Generator
do
    local function generatorIterator(self)
        return self
    end
    local function generatorNext(self, ...)
        local co = self.____coroutine
        if coroutine.status(co) == "dead" then
            return {done = true}
        end
        local status, value = coroutine.resume(co, ...)
        if not status then
            error(value, 0)
        end
        return {
            value = value,
            done = coroutine.status(co) == "dead"
        }
    end
    function __TS__Generator(fn)
        return function(...)
            local args = {...}
            local argsLength = __TS__CountVarargs(...)
            return {
                ____coroutine = coroutine.create(function() return fn(__TS__Unpack(args, 1, argsLength)) end),
                [Symbol.iterator] = generatorIterator,
                next = generatorNext
            }
        end
    end
end

local function __TS__InstanceOfObject(value)
    local valueType = type(value)
    return valueType == "table" or valueType == "function"
end

local function __TS__LuaIteratorSpread(self, state, firstKey)
    local results = {}
    local key, value = self(state, firstKey)
    while key do
        results[#results + 1] = {key, value}
        key, value = self(state, key)
    end
    return __TS__Unpack(results)
end

local Map
do
    Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return self.nextKey[key] ~= nil or self.lastKey == key
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, items[key]}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.values(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = items[key]}
                key = nextKey[key]
                return result
            end
        }
    end
    Map[Symbol.species] = Map
end

local __TS__Match = string.match

local __TS__MathAtan2 = math.atan2 or math.atan

local __TS__MathModf = math.modf

local function __TS__MathSign(val)
    if val > 0 then
        return 1
    elseif val < 0 then
        return -1
    end
    return 0
end

local function __TS__Number(value)
    local valueType = type(value)
    if valueType == "number" then
        return value
    elseif valueType == "string" then
        local numberValue = tonumber(value)
        if numberValue then
            return numberValue
        end
        if value == "Infinity" then
            return math.huge
        end
        if value == "-Infinity" then
            return -math.huge
        end
        local stringWithoutSpaces = string.gsub(value, "%s", "")
        if stringWithoutSpaces == "" then
            return 0
        end
        return 0 / 0
    elseif valueType == "boolean" then
        return value and 1 or 0
    else
        return 0 / 0
    end
end

local function __TS__NumberIsFinite(value)
    return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
end

local function __TS__NumberIsNaN(value)
    return value ~= value
end

local __TS__NumberToString
do
    local radixChars = "0123456789abcdefghijklmnopqrstuvwxyz"
    function __TS__NumberToString(self, radix)
        if radix == nil or radix == 10 or self == math.huge or self == -math.huge or self ~= self then
            return tostring(self)
        end
        radix = math.floor(radix)
        if radix < 2 or radix > 36 then
            error("toString() radix argument must be between 2 and 36", 0)
        end
        local integer, fraction = __TS__MathModf(math.abs(self))
        local result = ""
        if radix == 8 then
            result = string.format("%o", integer)
        elseif radix == 16 then
            result = string.format("%x", integer)
        else
            repeat
                do
                    result = __TS__StringAccess(radixChars, integer % radix) .. result
                    integer = math.floor(integer / radix)
                end
            until not (integer ~= 0)
        end
        if fraction ~= 0 then
            result = result .. "."
            local delta = 1e-16
            repeat
                do
                    fraction = fraction * radix
                    delta = delta * radix
                    local digit = math.floor(fraction)
                    result = result .. __TS__StringAccess(radixChars, digit)
                    fraction = fraction - digit
                end
            until not (fraction >= delta)
        end
        if self < 0 then
            result = "-" .. result
        end
        return result
    end
end

local function __TS__ObjectDefineProperty(target, key, desc)
    local luaKey = type(key) == "number" and key + 1 or key
    local value = rawget(target, luaKey)
    local hasGetterOrSetter = desc.get ~= nil or desc.set ~= nil
    local descriptor
    if hasGetterOrSetter then
        if value ~= nil then
            error(
                "Cannot redefine property: " .. tostring(key),
                0
            )
        end
        descriptor = desc
    else
        local valueExists = value ~= nil
        local ____desc_set_4 = desc.set
        local ____desc_get_5 = desc.get
        local ____temp_0
        if desc.configurable ~= nil then
            ____temp_0 = desc.configurable
        else
            ____temp_0 = valueExists
        end
        local ____temp_1
        if desc.enumerable ~= nil then
            ____temp_1 = desc.enumerable
        else
            ____temp_1 = valueExists
        end
        local ____temp_2
        if desc.writable ~= nil then
            ____temp_2 = desc.writable
        else
            ____temp_2 = valueExists
        end
        local ____temp_3
        if desc.value ~= nil then
            ____temp_3 = desc.value
        else
            ____temp_3 = value
        end
        descriptor = {
            set = ____desc_set_4,
            get = ____desc_get_5,
            configurable = ____temp_0,
            enumerable = ____temp_1,
            writable = ____temp_2,
            value = ____temp_3
        }
    end
    __TS__SetDescriptor(target, luaKey, descriptor)
    return target
end

local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end

local function __TS__ObjectFromEntries(entries)
    local obj = {}
    local iterable = entries
    if iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                break
            end
            local value = result.value
            obj[value[1]] = value[2]
        end
    else
        for ____, entry in ipairs(entries) do
            obj[entry[1]] = entry[2]
        end
    end
    return obj
end

local function __TS__ObjectKeys(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = key
    end
    return result
end

local function __TS__ObjectRest(target, usedProperties)
    local result = {}
    for property in pairs(target) do
        if not usedProperties[property] then
            result[property] = target[property]
        end
    end
    return result
end

local function __TS__ObjectValues(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = obj[key]
    end
    return result
end

local function __TS__ParseFloat(numberString)
    local infinityMatch = __TS__Match(numberString, "^%s*(-?Infinity)")
    if infinityMatch ~= nil then
        return __TS__StringAccess(infinityMatch, 0) == "-" and -math.huge or math.huge
    end
    local number = tonumber(__TS__Match(numberString, "^%s*(-?%d+%.?%d*)"))
    return number or 0 / 0
end

local function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if ____end ~= nil and start > ____end then
        start, ____end = ____end, start
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

local __TS__ParseInt
do
    local parseIntBasePattern = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
    function __TS__ParseInt(numberString, base)
        if base == nil then
            base = 10
            local hexMatch = __TS__Match(numberString, "^%s*-?0[xX]")
            if hexMatch ~= nil then
                base = 16
                numberString = __TS__Match(hexMatch, "-") and "-" .. __TS__StringSubstring(numberString, #hexMatch) or __TS__StringSubstring(numberString, #hexMatch)
            end
        end
        if base < 2 or base > 36 then
            return 0 / 0
        end
        local allowedDigits = base <= 10 and __TS__StringSubstring(parseIntBasePattern, 0, base) or __TS__StringSubstring(parseIntBasePattern, 0, 10 + 2 * (base - 10))
        local pattern = ("^%s*(-?[" .. allowedDigits) .. "]*)"
        local number = tonumber(
            __TS__Match(numberString, pattern),
            base
        )
        if number == nil then
            return 0 / 0
        end
        if number >= 0 then
            return math.floor(number)
        else
            return math.ceil(number)
        end
    end
end

local function __TS__PromiseAll(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = item.value
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = item
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = data
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        reject(nil, reason)
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAllSettled(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = {status = "fulfilled", value = item.value}
            elseif item.state == 2 then
                results[i + 1] = {status = "rejected", reason = item.rejectionReason}
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = {status = "fulfilled", value = item}
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = {status = "fulfilled", value = data}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        results[index + 1] = {status = "rejected", reason = reason}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAny(iterable)
    local rejections = {}
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                rejections[#rejections + 1] = item.rejectionReason
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    if #pending == 0 then
        return __TS__Promise.reject("No promises to resolve with .any()")
    end
    local numResolved = 0
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, data)
                        resolve(nil, data)
                    end,
                    function(____, reason)
                        rejections[#rejections + 1] = reason
                        numResolved = numResolved + 1
                        if numResolved == #pending then
                            reject(nil, {name = "AggregateError", message = "All Promises rejected", errors = rejections})
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseRace(iterable)
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, value) return resolve(nil, value) end,
                    function(____, reason) return reject(nil, reason) end
                )
            end
        end
    )
end

local Set
do
    Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return self.nextKey[value] ~= nil or self.lastKey == value
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, key}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.values(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    Set[Symbol.species] = Set
end

local function __TS__SparseArrayNew(...)
    local sparseArray = {...}
    sparseArray.sparseLength = __TS__CountVarargs(...)
    return sparseArray
end

local function __TS__SparseArrayPush(sparseArray, ...)
    local args = {...}
    local argsLen = __TS__CountVarargs(...)
    local listLen = sparseArray.sparseLength
    for i = 1, argsLen do
        sparseArray[listLen + i] = args[i]
    end
    sparseArray.sparseLength = listLen + argsLen
end

local function __TS__SparseArraySpread(sparseArray)
    local _unpack = unpack or table.unpack
    return _unpack(sparseArray, 1, sparseArray.sparseLength)
end

local WeakMap
do
    WeakMap = __TS__Class()
    WeakMap.name = "WeakMap"
    function WeakMap.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "WeakMap"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self.items[value[1]] = value[2]
            end
        else
            for ____, kvp in ipairs(entries) do
                self.items[kvp[1]] = kvp[2]
            end
        end
    end
    function WeakMap.prototype.delete(self, key)
        local contains = self:has(key)
        self.items[key] = nil
        return contains
    end
    function WeakMap.prototype.get(self, key)
        return self.items[key]
    end
    function WeakMap.prototype.has(self, key)
        return self.items[key] ~= nil
    end
    function WeakMap.prototype.set(self, key, value)
        self.items[key] = value
        return self
    end
    WeakMap[Symbol.species] = WeakMap
end

local WeakSet
do
    WeakSet = __TS__Class()
    WeakSet.name = "WeakSet"
    function WeakSet.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "WeakSet"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self.items[result.value] = true
            end
        else
            for ____, value in ipairs(values) do
                self.items[value] = true
            end
        end
    end
    function WeakSet.prototype.add(self, value)
        self.items[value] = true
        return self
    end
    function WeakSet.prototype.delete(self, value)
        local contains = self:has(value)
        self.items[value] = nil
        return contains
    end
    function WeakSet.prototype.has(self, value)
        return self.items[value] == true
    end
    WeakSet[Symbol.species] = WeakSet
end

local function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        local originalTraceback = debug.traceback
        _G.__TS__originalTraceback = originalTraceback
        debug.traceback = function(thread, message, level)
            local trace
            if thread == nil and message == nil and level == nil then
                trace = originalTraceback()
            elseif __TS__StringIncludes(_VERSION, "Lua 5.0") then
                trace = originalTraceback((("[Level " .. tostring(level)) .. "] ") .. tostring(message))
            else
                trace = originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local function replacer(____, file, srcFile, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (srcFile .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            local result = string.gsub(
                trace,
                "(%S+)%.lua:(%d+)",
                function(file, line) return replacer(nil, file .. ".lua", file .. ".ts", line) end
            )
            local function stringReplacer(____, file, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local chunkName = __TS__Match(file, "%[string \"([^\"]+)\"%]")
                    local sourceName = string.gsub(chunkName, ".lua$", ".ts")
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (sourceName .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            result = string.gsub(
                result,
                "(%[string \"[^\"]+\"%]):(%d+)",
                function(file, line) return stringReplacer(nil, file, line) end
            )
            return result
        end
    end
end

local function __TS__Spread(iterable)
    local arr = {}
    if type(iterable) == "string" then
        for i = 0, #iterable - 1 do
            arr[i + 1] = __TS__StringAccess(iterable, i)
        end
    else
        local len = 0
        for ____, item in __TS__Iterator(iterable) do
            len = len + 1
            arr[len] = item
        end
    end
    return __TS__Unpack(arr)
end

local function __TS__StringCharAt(self, pos)
    if pos ~= pos then
        pos = 0
    end
    if pos < 0 then
        return ""
    end
    return string.sub(self, pos + 1, pos + 1)
end

local function __TS__StringCharCodeAt(self, index)
    if index ~= index then
        index = 0
    end
    if index < 0 then
        return 0 / 0
    end
    return string.byte(self, index + 1) or 0 / 0
end

local function __TS__StringEndsWith(self, searchString, endPosition)
    if endPosition == nil or endPosition > #self then
        endPosition = #self
    end
    return string.sub(self, endPosition - #searchString + 1, endPosition) == searchString
end

local function __TS__StringPadEnd(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return self .. string.sub(
        fillString,
        1,
        math.floor(maxLength)
    )
end

local function __TS__StringPadStart(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return string.sub(
        fillString,
        1,
        math.floor(maxLength)
    ) .. self
end

local __TS__StringReplace
do
    local sub = string.sub
    function __TS__StringReplace(source, searchValue, replaceValue)
        local startPos, endPos = string.find(source, searchValue, nil, true)
        if not startPos then
            return source
        end
        local before = sub(source, 1, startPos - 1)
        local replacement = type(replaceValue) == "string" and replaceValue or replaceValue(nil, searchValue, startPos - 1, source)
        local after = sub(source, endPos + 1)
        return (before .. replacement) .. after
    end
end

local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end

local __TS__StringReplaceAll
do
    local sub = string.sub
    local find = string.find
    function __TS__StringReplaceAll(source, searchValue, replaceValue)
        if type(replaceValue) == "string" then
            local concat = table.concat(
                __TS__StringSplit(source, searchValue),
                replaceValue
            )
            if #searchValue == 0 then
                return (replaceValue .. concat) .. replaceValue
            end
            return concat
        end
        local parts = {}
        local partsIndex = 1
        if #searchValue == 0 then
            parts[1] = replaceValue(nil, "", 0, source)
            partsIndex = 2
            for i = 1, #source do
                parts[partsIndex] = sub(source, i, i)
                parts[partsIndex + 1] = replaceValue(nil, "", i, source)
                partsIndex = partsIndex + 2
            end
        else
            local currentPos = 1
            while true do
                local startPos, endPos = find(source, searchValue, currentPos, true)
                if not startPos then
                    break
                end
                parts[partsIndex] = sub(source, currentPos, startPos - 1)
                parts[partsIndex + 1] = replaceValue(nil, searchValue, startPos - 1, source)
                partsIndex = partsIndex + 2
                currentPos = endPos + 1
            end
            parts[partsIndex] = sub(source, currentPos)
        end
        return table.concat(parts)
    end
end

local function __TS__StringSlice(self, start, ____end)
    if start == nil or start ~= start then
        start = 0
    end
    if ____end ~= ____end then
        ____end = 0
    end
    if start >= 0 then
        start = start + 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = ____end - 1
    end
    return string.sub(self, start, ____end)
end

local function __TS__StringStartsWith(self, searchString, position)
    if position == nil or position < 0 then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end

local function __TS__StringSubstr(self, from, length)
    if from ~= from then
        from = 0
    end
    if length ~= nil then
        if length ~= length or length <= 0 then
            return ""
        end
        length = length + from
    end
    if from >= 0 then
        from = from + 1
    end
    return string.sub(self, from, length)
end

local function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end

local function __TS__StringTrimEnd(self)
    local result = string.gsub(self, "[%s ﻿]*$", "")
    return result
end

local function __TS__StringTrimStart(self)
    local result = string.gsub(self, "^[%s ﻿]*", "")
    return result
end

local __TS__SymbolRegistryFor, __TS__SymbolRegistryKeyFor
do
    local symbolRegistry = {}
    function __TS__SymbolRegistryFor(key)
        if not symbolRegistry[key] then
            symbolRegistry[key] = __TS__Symbol(key)
        end
        return symbolRegistry[key]
    end
    function __TS__SymbolRegistryKeyFor(sym)
        for key in pairs(symbolRegistry) do
            if symbolRegistry[key] == sym then
                return key
            end
        end
        return nil
    end
end

local function __TS__TypeOf(value)
    local luaType = type(value)
    if luaType == "table" then
        return "object"
    elseif luaType == "nil" then
        return "undefined"
    else
        return luaType
    end
end

return {
  __TS__ArrayConcat = __TS__ArrayConcat,
  __TS__ArrayEntries = __TS__ArrayEntries,
  __TS__ArrayEvery = __TS__ArrayEvery,
  __TS__ArrayFilter = __TS__ArrayFilter,
  __TS__ArrayForEach = __TS__ArrayForEach,
  __TS__ArrayFind = __TS__ArrayFind,
  __TS__ArrayFindIndex = __TS__ArrayFindIndex,
  __TS__ArrayFrom = __TS__ArrayFrom,
  __TS__ArrayIncludes = __TS__ArrayIncludes,
  __TS__ArrayIndexOf = __TS__ArrayIndexOf,
  __TS__ArrayIsArray = __TS__ArrayIsArray,
  __TS__ArrayJoin = __TS__ArrayJoin,
  __TS__ArrayMap = __TS__ArrayMap,
  __TS__ArrayPush = __TS__ArrayPush,
  __TS__ArrayPushArray = __TS__ArrayPushArray,
  __TS__ArrayReduce = __TS__ArrayReduce,
  __TS__ArrayReduceRight = __TS__ArrayReduceRight,
  __TS__ArrayReverse = __TS__ArrayReverse,
  __TS__ArrayUnshift = __TS__ArrayUnshift,
  __TS__ArraySort = __TS__ArraySort,
  __TS__ArraySlice = __TS__ArraySlice,
  __TS__ArraySome = __TS__ArraySome,
  __TS__ArraySplice = __TS__ArraySplice,
  __TS__ArrayToObject = __TS__ArrayToObject,
  __TS__ArrayFlat = __TS__ArrayFlat,
  __TS__ArrayFlatMap = __TS__ArrayFlatMap,
  __TS__ArraySetLength = __TS__ArraySetLength,
  __TS__AsyncAwaiter = __TS__AsyncAwaiter,
  __TS__Await = __TS__Await,
  __TS__Class = __TS__Class,
  __TS__ClassExtends = __TS__ClassExtends,
  __TS__CloneDescriptor = __TS__CloneDescriptor,
  __TS__CountVarargs = __TS__CountVarargs,
  __TS__Decorate = __TS__Decorate,
  __TS__DecorateParam = __TS__DecorateParam,
  __TS__Delete = __TS__Delete,
  __TS__DelegatedYield = __TS__DelegatedYield,
  Error = Error,
  RangeError = RangeError,
  ReferenceError = ReferenceError,
  SyntaxError = SyntaxError,
  TypeError = TypeError,
  URIError = URIError,
  __TS__FunctionBind = __TS__FunctionBind,
  __TS__Generator = __TS__Generator,
  __TS__InstanceOf = __TS__InstanceOf,
  __TS__InstanceOfObject = __TS__InstanceOfObject,
  __TS__Iterator = __TS__Iterator,
  __TS__LuaIteratorSpread = __TS__LuaIteratorSpread,
  Map = Map,
  __TS__Match = __TS__Match,
  __TS__MathAtan2 = __TS__MathAtan2,
  __TS__MathModf = __TS__MathModf,
  __TS__MathSign = __TS__MathSign,
  __TS__New = __TS__New,
  __TS__Number = __TS__Number,
  __TS__NumberIsFinite = __TS__NumberIsFinite,
  __TS__NumberIsNaN = __TS__NumberIsNaN,
  __TS__NumberToString = __TS__NumberToString,
  __TS__ObjectAssign = __TS__ObjectAssign,
  __TS__ObjectDefineProperty = __TS__ObjectDefineProperty,
  __TS__ObjectEntries = __TS__ObjectEntries,
  __TS__ObjectFromEntries = __TS__ObjectFromEntries,
  __TS__ObjectGetOwnPropertyDescriptor = __TS__ObjectGetOwnPropertyDescriptor,
  __TS__ObjectGetOwnPropertyDescriptors = __TS__ObjectGetOwnPropertyDescriptors,
  __TS__ObjectKeys = __TS__ObjectKeys,
  __TS__ObjectRest = __TS__ObjectRest,
  __TS__ObjectValues = __TS__ObjectValues,
  __TS__ParseFloat = __TS__ParseFloat,
  __TS__ParseInt = __TS__ParseInt,
  __TS__Promise = __TS__Promise,
  __TS__PromiseAll = __TS__PromiseAll,
  __TS__PromiseAllSettled = __TS__PromiseAllSettled,
  __TS__PromiseAny = __TS__PromiseAny,
  __TS__PromiseRace = __TS__PromiseRace,
  Set = Set,
  __TS__SetDescriptor = __TS__SetDescriptor,
  __TS__SparseArrayNew = __TS__SparseArrayNew,
  __TS__SparseArrayPush = __TS__SparseArrayPush,
  __TS__SparseArraySpread = __TS__SparseArraySpread,
  WeakMap = WeakMap,
  WeakSet = WeakSet,
  __TS__SourceMapTraceBack = __TS__SourceMapTraceBack,
  __TS__Spread = __TS__Spread,
  __TS__StringAccess = __TS__StringAccess,
  __TS__StringCharAt = __TS__StringCharAt,
  __TS__StringCharCodeAt = __TS__StringCharCodeAt,
  __TS__StringEndsWith = __TS__StringEndsWith,
  __TS__StringIncludes = __TS__StringIncludes,
  __TS__StringPadEnd = __TS__StringPadEnd,
  __TS__StringPadStart = __TS__StringPadStart,
  __TS__StringReplace = __TS__StringReplace,
  __TS__StringReplaceAll = __TS__StringReplaceAll,
  __TS__StringSlice = __TS__StringSlice,
  __TS__StringSplit = __TS__StringSplit,
  __TS__StringStartsWith = __TS__StringStartsWith,
  __TS__StringSubstr = __TS__StringSubstr,
  __TS__StringSubstring = __TS__StringSubstring,
  __TS__StringTrim = __TS__StringTrim,
  __TS__StringTrimEnd = __TS__StringTrimEnd,
  __TS__StringTrimStart = __TS__StringTrimStart,
  __TS__Symbol = __TS__Symbol,
  Symbol = Symbol,
  __TS__SymbolRegistryFor = __TS__SymbolRegistryFor,
  __TS__SymbolRegistryKeyFor = __TS__SymbolRegistryKeyFor,
  __TS__TypeOf = __TS__TypeOf,
  __TS__Unpack = __TS__Unpack
}
 end,
["colourMapping"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local ____exports = {}
local colourMapping = {
    {1, -1, 1},
    {39, -1, 1},
    {-1, 1, 32768},
    {-1, 49, 32768},
    {30, 40, 32768},
    {31, 41, 64},
    {32, 42, 8192},
    {33, 43, 2},
    {34, 44, 8},
    {35, 45, 1024},
    {36, 46, 512},
    {37, 47, 1},
    {90, 100, 128},
    {91, 101, 16384},
    {92, 102, 32},
    {93, 103, 16},
    {94, 104, 2048},
    {95, 105, 4}
}
local function findForeground(____, ansi)
    local found = __TS__ArrayFind(
        colourMapping,
        function(____, ____bindingPattern0)
            local foreground
            foreground = ____bindingPattern0[1]
            local background = ____bindingPattern0[2]
            local computercraft = ____bindingPattern0[3]
            return foreground == ansi
        end
    )
    if found then
        return found[3] >= 0 and found[3] or nil
    end
    return nil
end
local function findBackground(____, ansi)
    local found = __TS__ArrayFind(
        colourMapping,
        function(____, ____bindingPattern0)
            local background
            local foreground = ____bindingPattern0[1]
            background = ____bindingPattern0[2]
            local computercraft = ____bindingPattern0[3]
            return background == ansi
        end
    )
    if found then
        return found[3] >= 0 and found[3] or nil
    end
    return nil
end
____exports.findBackground = findBackground
____exports.findForeground = findForeground
return ____exports
 end,
["TerminalParser"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ArrayConcat = ____lualib.__TS__ArrayConcat
local __TS__Class = ____lualib.__TS__Class
local __TS__StringCharCodeAt = ____lualib.__TS__StringCharCodeAt
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__StringCharAt = ____lualib.__TS__StringCharAt
local ____exports = {}
--- range function for numbers [a, .., b-1]
-- 
-- @param a
-- @param b
-- @return
local function range(self, a, b)
    local numbers = {}
    do
        local i = a
        while i < b do
            numbers[#numbers + 1] = i
            i = i + 1
        end
    end
    return numbers
end
--- Add a transition to the transition table.
-- 
-- @param table - table to add transition
-- @param inp - input character code
-- @param state - current state
-- @param action - action to be taken
-- @param next - next state
local function addToTransitionTable(self, ____table, inp, state, action, next)
    if action == nil then
        action = 0
    end
    ____table[bit.bor(
        bit.blshift(state, 8),
        inp
    ) + 1] = bit.bor(
        bit.blshift(
            bit.bor(action, 0),
            4
        ),
        next == nil and state or next
    )
end
--- Add multiple transitions to the transition table.
-- 
-- @param table - table to add transition
-- @param inps - array of input character codes
-- @param state - current state
-- @param action - action to be taken
-- @param next - next state
local function add_list(self, ____table, inps, state, action, next)
    do
        local i = 0
        while i < #inps do
            addToTransitionTable(
                nil,
                ____table,
                inps[i + 1],
                state,
                action,
                next
            )
            i = i + 1
        end
    end
end
--- global definition of printables and executables
local PRINTABLES = range(nil, 32, 127)
local EXECUTABLES = range(nil, 0, 24)
EXECUTABLES[#EXECUTABLES + 1] = 25
EXECUTABLES = __TS__ArrayConcat(
    EXECUTABLES,
    range(nil, 28, 32)
)
--- create the standard transition table - used by all parser instances
-- 
--     table[state << 8 | character code] = action << 4 | next state
-- 
--     - states are indices of STATES (0 to 13)
--     - control character codes defined from 0 to 159 (C0 and C1)
--     - actions are indices of ACTIONS (0 to 14)
--     - any higher character than 159 is handled by the 'error' action
local TRANSITION_TABLE = (function(self)
    local t = {}
    do
        local state = 0
        while state < 14 do
            do
                local code = 0
                while code < 160 do
                    t[bit.bor(
                        bit.blshift(state, 8),
                        code
                    ) + 1] = 16
                    code = code + 1
                end
            end
            state = state + 1
        end
    end
    add_list(
        nil,
        t,
        PRINTABLES,
        0,
        2
    )
    do
        local state = 0
        while state < 14 do
            add_list(
                nil,
                t,
                {24, 26, 153, 154},
                state,
                3,
                0
            )
            add_list(
                nil,
                t,
                range(nil, 128, 144),
                state,
                3,
                0
            )
            add_list(
                nil,
                t,
                range(nil, 144, 152),
                state,
                3,
                0
            )
            addToTransitionTable(
                nil,
                t,
                156,
                state,
                0,
                0
            )
            addToTransitionTable(
                nil,
                t,
                27,
                state,
                11,
                1
            )
            addToTransitionTable(
                nil,
                t,
                157,
                state,
                4,
                8
            )
            add_list(
                nil,
                t,
                {152, 158, 159},
                state,
                0,
                7
            )
            addToTransitionTable(
                nil,
                t,
                155,
                state,
                11,
                3
            )
            addToTransitionTable(
                nil,
                t,
                144,
                state,
                11,
                9
            )
            state = state + 1
        end
    end
    add_list(
        nil,
        t,
        EXECUTABLES,
        0,
        3
    )
    add_list(
        nil,
        t,
        EXECUTABLES,
        1,
        3
    )
    addToTransitionTable(nil, t, 127, 1)
    add_list(nil, t, EXECUTABLES, 8)
    add_list(
        nil,
        t,
        EXECUTABLES,
        3,
        3
    )
    addToTransitionTable(nil, t, 127, 3)
    add_list(
        nil,
        t,
        EXECUTABLES,
        4,
        3
    )
    addToTransitionTable(nil, t, 127, 4)
    add_list(
        nil,
        t,
        EXECUTABLES,
        6,
        3
    )
    add_list(
        nil,
        t,
        EXECUTABLES,
        5,
        3
    )
    addToTransitionTable(nil, t, 127, 5)
    add_list(
        nil,
        t,
        EXECUTABLES,
        2,
        3
    )
    addToTransitionTable(nil, t, 127, 2)
    addToTransitionTable(
        nil,
        t,
        93,
        1,
        4,
        8
    )
    add_list(
        nil,
        t,
        PRINTABLES,
        8,
        5
    )
    addToTransitionTable(
        nil,
        t,
        127,
        8,
        5
    )
    add_list(
        nil,
        t,
        {
            156,
            27,
            24,
            26,
            7
        },
        8,
        6,
        0
    )
    add_list(
        nil,
        t,
        range(nil, 28, 32),
        8,
        0
    )
    add_list(
        nil,
        t,
        {88, 94, 95},
        1,
        0,
        7
    )
    add_list(nil, t, PRINTABLES, 7)
    add_list(nil, t, EXECUTABLES, 7)
    addToTransitionTable(nil, t, 127, 7)
    addToTransitionTable(
        nil,
        t,
        156,
        7,
        0,
        0
    )
    addToTransitionTable(
        nil,
        t,
        91,
        1,
        11,
        3
    )
    add_list(
        nil,
        t,
        range(nil, 64, 127),
        3,
        7,
        0
    )
    add_list(
        nil,
        t,
        range(nil, 48, 58),
        3,
        8,
        4
    )
    addToTransitionTable(
        nil,
        t,
        59,
        3,
        8,
        4
    )
    add_list(
        nil,
        t,
        {60, 61, 62, 63},
        3,
        9,
        4
    )
    add_list(
        nil,
        t,
        range(nil, 48, 58),
        4,
        8
    )
    addToTransitionTable(
        nil,
        t,
        59,
        4,
        8
    )
    add_list(
        nil,
        t,
        range(nil, 64, 127),
        4,
        7,
        0
    )
    add_list(
        nil,
        t,
        {
            58,
            60,
            61,
            62,
            63
        },
        4,
        0,
        6
    )
    add_list(
        nil,
        t,
        range(nil, 32, 64),
        6
    )
    addToTransitionTable(nil, t, 127, 6)
    add_list(
        nil,
        t,
        range(nil, 64, 127),
        6,
        0,
        0
    )
    addToTransitionTable(
        nil,
        t,
        58,
        3,
        0,
        6
    )
    add_list(
        nil,
        t,
        range(nil, 32, 48),
        3,
        9,
        5
    )
    add_list(
        nil,
        t,
        range(nil, 32, 48),
        5,
        9
    )
    add_list(
        nil,
        t,
        range(nil, 48, 64),
        5,
        0,
        6
    )
    add_list(
        nil,
        t,
        range(nil, 64, 127),
        5,
        7,
        0
    )
    add_list(
        nil,
        t,
        range(nil, 32, 48),
        4,
        9,
        5
    )
    add_list(
        nil,
        t,
        range(nil, 32, 48),
        1,
        9,
        2
    )
    add_list(
        nil,
        t,
        range(nil, 32, 48),
        2,
        9
    )
    add_list(
        nil,
        t,
        range(nil, 48, 127),
        2,
        10,
        0
    )
    add_list(
        nil,
        t,
        range(nil, 48, 80),
        1,
        10,
        0
    )
    add_list(
        nil,
        t,
        {
            81,
            82,
            83,
            84,
            85,
            86,
            87,
            89,
            90,
            92
        },
        1,
        10,
        0
    )
    add_list(
        nil,
        t,
        range(nil, 96, 127),
        1,
        10,
        0
    )
    addToTransitionTable(
        nil,
        t,
        80,
        1,
        11,
        9
    )
    add_list(nil, t, EXECUTABLES, 9)
    addToTransitionTable(nil, t, 127, 9)
    add_list(
        nil,
        t,
        range(nil, 28, 32),
        9
    )
    add_list(
        nil,
        t,
        range(nil, 32, 48),
        9,
        9,
        12
    )
    addToTransitionTable(
        nil,
        t,
        58,
        9,
        0,
        11
    )
    add_list(
        nil,
        t,
        range(nil, 48, 58),
        9,
        8,
        10
    )
    addToTransitionTable(
        nil,
        t,
        59,
        9,
        8,
        10
    )
    add_list(
        nil,
        t,
        {60, 61, 62, 63},
        9,
        9,
        10
    )
    add_list(nil, t, EXECUTABLES, 11)
    add_list(
        nil,
        t,
        range(nil, 32, 128),
        11
    )
    add_list(
        nil,
        t,
        range(nil, 28, 32),
        11
    )
    add_list(nil, t, EXECUTABLES, 10)
    addToTransitionTable(nil, t, 127, 10)
    add_list(
        nil,
        t,
        range(nil, 28, 32),
        10
    )
    add_list(
        nil,
        t,
        range(nil, 48, 58),
        10,
        8
    )
    addToTransitionTable(
        nil,
        t,
        59,
        10,
        8
    )
    add_list(
        nil,
        t,
        {
            58,
            60,
            61,
            62,
            63
        },
        10,
        0,
        11
    )
    add_list(
        nil,
        t,
        range(nil, 32, 48),
        10,
        9,
        12
    )
    add_list(nil, t, EXECUTABLES, 12)
    addToTransitionTable(nil, t, 127, 12)
    add_list(
        nil,
        t,
        range(nil, 28, 32),
        12
    )
    add_list(
        nil,
        t,
        range(nil, 32, 48),
        12,
        9
    )
    add_list(
        nil,
        t,
        range(nil, 48, 64),
        12,
        0,
        11
    )
    add_list(
        nil,
        t,
        range(nil, 64, 127),
        12,
        12,
        13
    )
    add_list(
        nil,
        t,
        range(nil, 64, 127),
        10,
        12,
        13
    )
    add_list(
        nil,
        t,
        range(nil, 64, 127),
        9,
        12,
        13
    )
    add_list(
        nil,
        t,
        EXECUTABLES,
        13,
        13
    )
    add_list(
        nil,
        t,
        PRINTABLES,
        13,
        13
    )
    addToTransitionTable(nil, t, 127, 13)
    add_list(
        nil,
        t,
        {27, 156},
        13,
        14,
        0
    )
    return t
end)(nil)
local TerminalParser = __TS__Class()
TerminalParser.name = "TerminalParser"
function TerminalParser.prototype.____constructor(self, callbacks)
    self.initial_state = 0
    self.current_state = bit.bor(self.initial_state, 0)
    self.transitions = {unpack(TRANSITION_TABLE)}
    self.osc = ""
    self.params = {0}
    self.collected = ""
    self.callbacks = callbacks
end
function TerminalParser.prototype.reset(self)
    self.current_state = bit.bor(self.initial_state, 0)
    self.osc = ""
    self.params = {0}
    self.collected = ""
end
function TerminalParser.prototype.parse(self, s)
    local code = 0
    local transition = 0
    local ____error = false
    local current_state = bit.bor(self.current_state, 0)
    local printed = -1
    local dcs = -1
    local osc = self.osc
    local collected = self.collected
    local params = self.params
    do
        local i = 0
        local l = bit.bor(#s, 0)
        while i < l do
            code = bit.bor(
                __TS__StringCharCodeAt(s, i),
                0
            )
            if current_state == 0 and code > 31 and code < 128 then
                printed = printed >= 0 and bit.bor(printed, 0) or bit.bor(i, 0)
            else
                transition = bit.bor(
                    code < 160 and bit.bor(
                        self.transitions[bit.bor(
                            bit.bor(
                                bit.blshift(current_state, 8),
                                code
                            ),
                            0
                        ) + 1],
                        0
                    ) or 16,
                    0
                )
                repeat
                    local ____switch17 = bit.bor(
                        bit.brshift(transition, 4),
                        0
                    )
                    local ____cond17 = ____switch17 == 2
                    if ____cond17 then
                        printed = printed + 1 ~= 0 and bit.bor(printed, 0) or bit.bor(i, 0)
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 3
                    if ____cond17 then
                        if printed >= 0 then
                            local ____this_1
                            ____this_1 = self.callbacks
                            local ____opt_0 = ____this_1.inst_p
                            if ____opt_0 ~= nil then
                                ____opt_0(
                                    ____this_1,
                                    __TS__StringSubstring(s, printed, i)
                                )
                            end
                            printed = -1
                        end
                        local ____this_3
                        ____this_3 = self.callbacks
                        local ____opt_2 = ____this_3.inst_x
                        if ____opt_2 ~= nil then
                            ____opt_2(
                                ____this_3,
                                string.char(code)
                            )
                        end
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 0
                    if ____cond17 then
                        if printed >= 0 then
                            local ____this_5
                            ____this_5 = self.callbacks
                            local ____opt_4 = ____this_5.inst_p
                            if ____opt_4 ~= nil then
                                ____opt_4(
                                    ____this_5,
                                    __TS__StringSubstring(s, printed, i)
                                )
                            end
                            printed = -1
                        elseif dcs + 1 ~= 0 then
                            local ____this_7
                            ____this_7 = self.callbacks
                            local ____opt_6 = ____this_7.inst_P
                            if ____opt_6 ~= nil then
                                ____opt_6(
                                    ____this_7,
                                    __TS__StringSubstring(s, dcs, i)
                                )
                            end
                            dcs = -1
                        end
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 1
                    if ____cond17 then
                        if code > 159 then
                            repeat
                                local ____switch22 = current_state
                                local ____cond22 = ____switch22 == 0
                                if ____cond22 then
                                    printed = not (printed + 1) and bit.bor(i, 0) or bit.bor(printed, 0)
                                    break
                                end
                                ____cond22 = ____cond22 or ____switch22 == 8
                                if ____cond22 then
                                    osc = osc .. string.char(code)
                                    transition = bit.bor(
                                        bit.bor(transition, 8),
                                        0
                                    )
                                    break
                                end
                                ____cond22 = ____cond22 or ____switch22 == 6
                                if ____cond22 then
                                    transition = bit.bor(
                                        bit.bor(transition, 6),
                                        0
                                    )
                                    break
                                end
                                ____cond22 = ____cond22 or ____switch22 == 11
                                if ____cond22 then
                                    transition = bit.bor(
                                        bit.bor(transition, 11),
                                        0
                                    )
                                    break
                                end
                                ____cond22 = ____cond22 or ____switch22 == 13
                                if ____cond22 then
                                    if not (dcs + 1) then
                                        dcs = bit.bor(i, 0)
                                    end
                                    transition = bit.bor(
                                        bit.bor(transition, 13),
                                        0
                                    )
                                    break
                                end
                                do
                                    ____error = true
                                end
                            until true
                        else
                            ____error = true
                        end
                        if ____error then
                            local ____this_9
                            ____this_9 = self.callbacks
                            local ____opt_8 = ____this_9.inst_E
                            if ____opt_8 and ____opt_8(
                                ____this_9,
                                {
                                    pos = i,
                                    character = string.char(code),
                                    state = current_state,
                                    print = printed,
                                    dcs = dcs,
                                    osc = osc,
                                    collect = collected,
                                    params = params
                                }
                            ) then
                                return
                            end
                            ____error = false
                        end
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 7
                    if ____cond17 then
                        local ____this_11
                        ____this_11 = self.callbacks
                        local ____opt_10 = ____this_11.inst_c
                        if ____opt_10 ~= nil then
                            ____opt_10(
                                ____this_11,
                                collected,
                                params,
                                string.char(code)
                            )
                        end
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 8
                    if ____cond17 then
                        if code == 59 then
                            params[#params + 1] = 0
                        else
                            params[#params] = bit.bor(params[#params] * 10 + code - 48, 0)
                        end
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 9
                    if ____cond17 then
                        collected = collected .. string.char(code)
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 10
                    if ____cond17 then
                        local ____this_13
                        ____this_13 = self.callbacks
                        local ____opt_12 = ____this_13.inst_e
                        if ____opt_12 ~= nil then
                            ____opt_12(
                                ____this_13,
                                collected,
                                string.char(code)
                            )
                        end
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 11
                    if ____cond17 then
                        if printed >= 0 then
                            local ____this_15
                            ____this_15 = self.callbacks
                            local ____opt_14 = ____this_15.inst_p
                            if ____opt_14 ~= nil then
                                ____opt_14(
                                    ____this_15,
                                    __TS__StringSubstring(s, printed, i)
                                )
                            end
                            printed = -1
                        end
                        osc = ""
                        params = {0}
                        collected = ""
                        dcs = -1
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 12
                    if ____cond17 then
                        local ____this_17
                        ____this_17 = self.callbacks
                        local ____opt_16 = ____this_17.inst_H
                        if ____opt_16 ~= nil then
                            ____opt_16(
                                ____this_17,
                                collected,
                                params,
                                string.char(code)
                            )
                        end
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 13
                    if ____cond17 then
                        if not (dcs + 1) then
                            dcs = bit.bor(i, 0)
                        end
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 14
                    if ____cond17 then
                        if dcs >= 0 then
                            local ____this_19
                            ____this_19 = self.callbacks
                            local ____opt_18 = ____this_19.inst_P
                            if ____opt_18 ~= nil then
                                ____opt_18(
                                    ____this_19,
                                    __TS__StringSubstring(s, dcs, i)
                                )
                            end
                        end
                        self.callbacks:inst_U()
                        if code == 27 then
                            transition = bit.bor(
                                bit.bor(transition, 1),
                                0
                            )
                        end
                        osc = ""
                        params = {0}
                        collected = ""
                        dcs = -1
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 4
                    if ____cond17 then
                        if printed ~= -1 then
                            local ____this_21
                            ____this_21 = self.callbacks
                            local ____opt_20 = ____this_21.inst_p
                            if ____opt_20 ~= nil then
                                ____opt_20(
                                    ____this_21,
                                    __TS__StringSubstring(s, printed, i)
                                )
                            end
                            printed = -1
                        end
                        osc = ""
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 5
                    if ____cond17 then
                        osc = osc .. __TS__StringCharAt(s, i)
                        break
                    end
                    ____cond17 = ____cond17 or ____switch17 == 6
                    if ____cond17 then
                        if osc and code ~= 24 and code ~= 26 then
                            local ____this_23
                            ____this_23 = self.callbacks
                            local ____opt_22 = ____this_23.inst_o
                            if ____opt_22 ~= nil then
                                ____opt_22(____this_23, osc)
                            end
                        end
                        if code == 27 then
                            transition = bit.bor(
                                bit.bor(transition, 1),
                                0
                            )
                        end
                        osc = ""
                        params = {0}
                        collected = ""
                        dcs = -1
                        break
                    end
                until true
            end
            current_state = bit.bor(
                bit.band(transition, 15),
                0
            )
            i = i + 1
        end
    end
    local ____this_25
    ____this_25 = self.callbacks
    local ____opt_24 = ____this_25.debugger
    if ____opt_24 ~= nil then
        ____opt_24(
            ____this_25,
            (("awoo state=" .. tostring(current_state)) .. " printed=") .. tostring(printed)
        )
    end
    if current_state == 0 and printed >= 0 then
        local ____this_27
        ____this_27 = self.callbacks
        local ____opt_26 = ____this_27.inst_p
        if ____opt_26 ~= nil then
            ____opt_26(
                ____this_27,
                __TS__StringSubstring(s, printed)
            )
        end
    elseif current_state == 13 and dcs >= 0 then
        local ____this_29
        ____this_29 = self.callbacks
        local ____opt_28 = ____this_29.inst_P
        if ____opt_28 ~= nil then
            ____opt_28(
                ____this_29,
                __TS__StringSubstring(s, dcs)
            )
        end
    end
    self.osc = osc
    self.collected = collected
    self.params = params
    self.current_state = bit.bor(current_state, 0)
end
____exports.TerminalParser = TerminalParser
return ____exports
 end,
["BufferlessFrame"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____colourMapping = require("colourMapping")
local findBackground = ____colourMapping.findBackground
local findForeground = ____colourMapping.findForeground
local BufferlessFrame = __TS__Class()
BufferlessFrame.name = "BufferlessFrame"
function BufferlessFrame.prototype.____constructor(self, websocket)
    self.savedX = -1
    self.savedY = -1
    self.websocket = websocket
    local screenWidth, screenHeight = term.getSize()
    self.marginTop = 0
    self.marginBottom = screenHeight
    self.topPane = window.create(
        term.current(),
        1,
        1,
        1,
        1
    )
    self.scrollPane = window.create(
        term.current(),
        1,
        1,
        1,
        1
    )
    self.bottomPane = window.create(
        term.current(),
        1,
        1,
        1,
        1
    )
    self.scrollPane.clear()
    self.topPane.clear()
    self.bottomPane.clear()
    self.scrollPane.setCursorBlink(true)
    self.topPane.setCursorBlink(true)
    self.bottomPane.setCursorBlink(true)
    self:syncPaneSizes()
    self:setCursorPos(1, 1)
    self:syncPanePositions(1, 1)
end
function BufferlessFrame.prototype.syncPaneSizes(self)
    local screenWidth, screenHeight = term.getSize()
    self.topPane.reposition(1, 1, screenWidth, self.marginTop)
    self.scrollPane.reposition(1, self.marginTop + 1, screenWidth, self.marginBottom - self.marginTop)
    self.bottomPane.reposition(1, self.marginBottom, screenWidth, screenHeight - self.marginBottom)
end
function BufferlessFrame.prototype.syncPanePositions(self, xPos, yPos)
    self.topPane.setCursorPos(xPos, yPos)
    self.bottomPane.setCursorPos(xPos, yPos - self.marginBottom)
    self.scrollPane.setCursorPos(xPos, yPos - self.marginTop)
end
function BufferlessFrame.prototype.setCursorPos(self, x, y)
    local screenX, screenY = term.getSize()
    if x <= 0 then
        x = 1
    end
    if y <= 0 then
        y = 1
    end
    if x > screenX then
        x = screenX
    end
    if y > screenY then
        y = screenY
    end
    term.setCursorPos(x, y)
    self:syncPanePositions(x, y)
    term.setCursorPos(x, y)
end
function BufferlessFrame.prototype.write(self, input)
    local xPos, yPos = term.getCursorPos()
    self:syncPanePositions(xPos, yPos)
    if yPos <= self.marginTop then
        self.topPane.write(input)
        local newXPos, newYPos = self.topPane.getCursorPos()
        self:setCursorPos(newXPos, newYPos)
    elseif yPos > self.marginBottom then
        self.bottomPane.write(input)
        local newXPos, newYPos = self.bottomPane.getCursorPos()
        self:setCursorPos(newXPos, newYPos + self.marginBottom)
    else
        self.scrollPane.write(input)
        local newXPos, newYPos = self.scrollPane.getCursorPos()
        self:setCursorPos(newXPos, newYPos + self.marginTop)
    end
end
function BufferlessFrame.prototype.inst_p(self, input)
    self:write(input)
end
function BufferlessFrame.prototype.inst_o(self, s)
end
function BufferlessFrame.prototype.inst_x(self, flag)
    local cursorX, cursorY = self.scrollPane.getCursorPos()
    local screenX, screenY = self.scrollPane.getSize()
    if flag == "\n" then
        if cursorY >= screenY then
            self.scrollPane.scroll(1)
            self:setCursorPos(1, cursorY)
        else
            self:setCursorPos(1, cursorY + 1)
        end
    elseif flag == "\r" then
        self:setCursorPos(1, cursorY)
    elseif flag == "\b" then
        if cursorX == 1 then
            self:setCursorPos(
                screenX,
                math.max(1, cursorY - 1)
            )
        else
            self:setCursorPos(
                math.max(1, cursorX - 1),
                cursorY
            )
        end
    elseif flag == "" then
        local speaker = peripheral.find("speaker")
        if speaker ~= nil then
            speaker.playSound("minecraft:block.bell.use")
        end
    elseif flag == "" then
        for ____, side in ipairs(redstone.getSides()) do
            redstone.setOutput(side, true)
        end
    elseif flag == "" then
        for ____, side in ipairs(redstone.getSides()) do
            redstone.setOutput(side, false)
        end
    end
end
function BufferlessFrame.prototype.inst_c(self, collected, params, flag)
    if flag == "K" then
        local param = unpack(params)
        local cursorX, cursorY = term.getCursorPos()
        local screenWidth, screenHeight = term.getSize()
        if #params == 0 or param == 0 then
            do
                local i = cursorX
                while i <= screenWidth do
                    self:setCursorPos(i, cursorY)
                    self:write(" ")
                    i = i + 1
                end
            end
            self:setCursorPos(cursorX, cursorY)
        elseif param == 1 then
            do
                local i = 1
                while i <= cursorX do
                    self:setCursorPos(i, cursorY)
                    self:write(" ")
                    i = i + 1
                end
            end
            self:setCursorPos(cursorX, cursorY)
        elseif param == 2 then
            term.clearLine()
        end
    elseif flag == "J" then
        local param = unpack(params)
        local cursorX, cursorY = term.getCursorPos()
        local screenWidth, screenHeight = term.getSize()
        if #params == 0 or param == 0 then
            do
                local i = cursorY
                while i <= screenHeight do
                    self:setCursorPos(1, i)
                    term.clearLine()
                    i = i + 1
                end
            end
            do
                local i = cursorX
                while i <= screenWidth do
                    self:setCursorPos(i, cursorY)
                    self:write(" ")
                    i = i + 1
                end
            end
            self:setCursorPos(cursorX, cursorY)
        elseif param == 1 then
            do
                local i = 1
                while i < cursorY do
                    self:setCursorPos(1, i)
                    term.clearLine()
                    i = i + 1
                end
            end
            do
                local i = 1
                while i < cursorX do
                    self:setCursorPos(i, cursorY)
                    self:write(" ")
                    i = i + 1
                end
            end
            self:setCursorPos(cursorX, cursorY)
        elseif param == 2 then
            self.topPane.clear()
            self.scrollPane.clear()
            self.bottomPane.clear()
            term.clear()
            self:setCursorPos(cursorX, cursorY)
        end
    elseif flag == "H" or flag == "f" then
        local row, col = unpack(params)
        if type(row) ~= "number" then
            row = 0
        end
        if type(col) ~= "number" then
            col = 0
        end
        if row < 0 then
            row = 0
        end
        if col < 0 then
            col = 0
        end
        self:setCursorPos(col + 1, row + 1)
    elseif flag == "A" or flag == "B" or flag == "C" or flag == "D" or flag == "E" or flag == "F" or flag == "G" then
        local posX, posY = term.getCursorPos()
        local x = posX
        local y = posY
        local amount = unpack(params)
        if flag == "A" then
            y = y - amount
        end
        if flag == "B" then
            y = y + amount
        end
        if flag == "C" then
            x = x + amount
        end
        if flag == "D" then
            x = x - amount
        end
        if flag == "E" then
            x = 1
            y = y + amount
        end
        if flag == "F" then
            x = 1
            y = y - amount
        end
        if flag == "G" then
            x = amount
        end
        if x < 1 then
            x = 1
        end
        if y < 1 then
            y = 1
        end
        self:setCursorPos(x, y)
    elseif flag == "m" then
        __TS__ArrayForEach(
            params,
            function(____, param)
                local newBackground = findBackground(nil, param)
                local newForeground = findForeground(nil, param)
                if param == 0 then
                    self.scrollPane.setBackgroundColour(colours.black)
                    self.topPane.setBackgroundColour(colours.black)
                    self.bottomPane.setBackgroundColour(colours.black)
                    self.scrollPane.setTextColour(colours.white)
                    self.topPane.setTextColour(colours.white)
                    self.bottomPane.setTextColour(colours.white)
                elseif newBackground then
                    self.scrollPane.setBackgroundColor(newBackground)
                    self.topPane.setBackgroundColor(newBackground)
                    self.bottomPane.setBackgroundColor(newBackground)
                elseif newForeground then
                    self.scrollPane.setTextColor(newForeground)
                    self.topPane.setTextColor(newForeground)
                    self.bottomPane.setTextColor(newForeground)
                end
            end
        )
    elseif flag == "r" then
        local cursorX, cursorY = term.getCursorPos()
        local marginTop, marginBottom = unpack(params)
        self.marginTop = marginTop
        self.marginBottom = marginBottom
        self:syncPaneSizes()
        self:setCursorPos(cursorX, cursorY)
        self:syncPanePositions(cursorX, cursorY)
    end
end
function BufferlessFrame.prototype.inst_e(self, collected, flag)
    if collected == "" and flag == "7" then
        local cursorX, cursorY = term.getCursorPos()
        self.savedX = cursorX
        self.savedY = cursorY
    end
    if collected == "" and flag == "8" then
        if self.savedX > 0 and self.savedY > 0 then
            term.setCursorPos(self.savedX, self.savedY)
            self:syncPanePositions(self.savedX, self.savedY)
        end
    end
end
function BufferlessFrame.prototype.inst_H(self, collected, params, flag)
end
function BufferlessFrame.prototype.inst_P(self, data)
end
function BufferlessFrame.prototype.inst_U(self)
end
function BufferlessFrame.prototype.complete(self)
end
function BufferlessFrame.prototype.destroy(self)
end
____exports.BufferlessFrame = BufferlessFrame
return ____exports
 end,
["JASON"] = function(...) 
local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local JASON = {
    stringify = function(self, data)
        return textutils.serializeJSON(data)
    end,
    parse = function(self, data)
        local parsedData, failureReason = textutils.unserializeJSON(data)
        if type(failureReason) == "string" then
            error(
                __TS__New(Error, (("Tried to parse " .. data) .. "z") .. failureReason),
                0
            )
        end
        return parsedData
    end
}
local function log(____, data)
    return print(JASON:stringify(data))
end
____exports.JASON = JASON
____exports.log = log
return ____exports
 end,
["Packet"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
local ____JASON = require("JASON")
local JASON = ____JASON.JASON
local PacketCrafter = __TS__Class()
PacketCrafter.name = "PacketCrafter"
function PacketCrafter.prototype.____constructor(self)
end
function PacketCrafter.make(self, id, data)
    return JASON:stringify({id = id, data = data})
end
function PacketCrafter.keypress(self, data)
    return PacketCrafter:make("k", data)
end
function PacketCrafter.writeToTerminal(self, data)
    return PacketCrafter:make("w", data)
end
function PacketCrafter.connect(self, data)
    return PacketCrafter:make("connect", data)
end
function PacketCrafter.debug(self, data)
    return PacketCrafter:make("debug", data)
end
____exports.PacketCrafter = PacketCrafter
return ____exports
 end,
["getCharacter"] = function(...) 
local ____lualib = require("lualib_bundle")
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local KEYMAP = __TS__New(Map)
KEYMAP:set("space", {" ", " ", 0, 0})
KEYMAP:set("apostrophe", {";", ":", 0, 0})
KEYMAP:set("comma", {",", "<", 0, 0})
KEYMAP:set("minus", {"-", "_", 0, 0})
KEYMAP:set("period", {".", ">", 0, 0})
KEYMAP:set("slash", {"/", "?", 0, 0})
KEYMAP:set("zero", {"0", ")", 0, 0})
KEYMAP:set("one", {"1", "!", 0, 0})
KEYMAP:set("two", {"2", "\"", 0, 0})
KEYMAP:set("three", {"3", "£", 0, 0})
KEYMAP:set("four", {"4", "$", 0, 0})
KEYMAP:set("five", {"5", "%", 0, 0})
KEYMAP:set("six", {"6", "^", 0, 0})
KEYMAP:set("seven", {"7", "&", 0, 0})
KEYMAP:set("eight", {"8", "*", 0, 0})
KEYMAP:set("nine", {"9", "(", 0, 0})
KEYMAP:set("semicolon", {";", ":", 0, 0})
KEYMAP:set("equals", {"=", "+", 0, 0})
KEYMAP:set("a", {"a", "A", "", 0})
KEYMAP:set("b", {"b", "B", "", 0})
KEYMAP:set("c", {"c", "C", "", 0})
KEYMAP:set("d", {"d", "D", "", 0})
KEYMAP:set("e", {"e", "E", "", 0})
KEYMAP:set("f", {"f", "F", "", 0})
KEYMAP:set("g", {"g", "G", "", 0})
KEYMAP:set("h", {"h", "H", "\b", 0})
KEYMAP:set("i", {"i", "I", "\t", 0})
KEYMAP:set("j", {"j", "J", "\n", 0})
KEYMAP:set("k", {"k", "K", "\v", 0})
KEYMAP:set("l", {"l", "L", "\f", 0})
KEYMAP:set("m", {"m", "M", "\r", 0})
KEYMAP:set("n", {"n", "N", "", 0})
KEYMAP:set("o", {"o", "O", "", 0})
KEYMAP:set("p", {"p", "P", "", 0})
KEYMAP:set("q", {"q", "Q", "", 0})
KEYMAP:set("r", {"r", "R", "", 0})
KEYMAP:set("s", {"s", "S", "", 0})
KEYMAP:set("t", {"t", "T", "", 0})
KEYMAP:set("u", {"u", "U", "", 0})
KEYMAP:set("v", {"v", "V", "", 0})
KEYMAP:set("w", {"w", "W", "", 0})
KEYMAP:set("x", {"x", "X", "", 0})
KEYMAP:set("y", {"y", "Y", "", 0})
KEYMAP:set("z", {"z", "Z", "", 0})
KEYMAP:set("leftBracket", {"[", 0, 0, 0})
KEYMAP:set("backslash", {"\\", "|", 0, 0})
KEYMAP:set("rightBracket", {"]", 0, 0, 0})
KEYMAP:set("grave", {"`", 0, 0, 0})
KEYMAP:set("world1", {0, 0, 0, 0})
KEYMAP:set("world2", {0, 0, 0, 0})
KEYMAP:set("enter", {"\r", 0, 0, 0})
KEYMAP:set("tab", {"\t", 0, 0, 0})
KEYMAP:set("backspace", {"\b", 0, 0, 0})
KEYMAP:set("insert", {0, 0, 0, 0})
KEYMAP:set("delete", {0, 0, 0, 0})
KEYMAP:set("right", {"[C", 0, 0, 0})
KEYMAP:set("left", {"[D", 0, 0, 0})
KEYMAP:set("down", {"[B", 0, 0, 0})
KEYMAP:set("up", {"[A", 0, 0, 0})
KEYMAP:set("pageUp", {0, 0, 0, 0})
KEYMAP:set("pageDown", {0, 0, 0, 0})
KEYMAP:set("home", {0, 0, 0, 0})
KEYMAP:set("end", {0, 0, 0, 0})
KEYMAP:set("capsLock", {0, 0, 0, 0})
KEYMAP:set("scrollLock", {0, 0, 0, 0})
KEYMAP:set("numLock", {0, 0, 0, 0})
KEYMAP:set("printScreen", {0, 0, 0, 0})
KEYMAP:set("pause", {0, 0, 0, 0})
KEYMAP:set("f1", {0, 0, 0, 0})
KEYMAP:set("f2", {0, 0, 0, 0})
KEYMAP:set("f3", {0, 0, 0, 0})
KEYMAP:set("f4", {0, 0, 0, 0})
KEYMAP:set("f5", {0, 0, 0, 0})
KEYMAP:set("f6", {0, 0, 0, 0})
KEYMAP:set("f7", {0, 0, 0, 0})
KEYMAP:set("f8", {0, 0, 0, 0})
KEYMAP:set("f9", {0, 0, 0, 0})
KEYMAP:set("f10", {0, 0, 0, 0})
KEYMAP:set("f11", {0, 0, 0, 0})
KEYMAP:set("f12", {0, 0, 0, 0})
KEYMAP:set("f13", {0, 0, 0, 0})
KEYMAP:set("f14", {0, 0, 0, 0})
KEYMAP:set("f15", {0, 0, 0, 0})
KEYMAP:set("f16", {0, 0, 0, 0})
KEYMAP:set("f17", {0, 0, 0, 0})
KEYMAP:set("f18", {0, 0, 0, 0})
KEYMAP:set("f19", {0, 0, 0, 0})
KEYMAP:set("f20", {0, 0, 0, 0})
KEYMAP:set("f21", {0, 0, 0, 0})
KEYMAP:set("f22", {0, 0, 0, 0})
KEYMAP:set("f23", {0, 0, 0, 0})
KEYMAP:set("f24", {0, 0, 0, 0})
KEYMAP:set("f25", {0, 0, 0, 0})
KEYMAP:set("numPad0", {0, 0, 0, 0})
KEYMAP:set("numPad1", {0, 0, 0, 0})
KEYMAP:set("numPad2", {0, 0, 0, 0})
KEYMAP:set("numPad3", {0, 0, 0, 0})
KEYMAP:set("numPad4", {0, 0, 0, 0})
KEYMAP:set("numPad5", {0, 0, 0, 0})
KEYMAP:set("numPad6", {0, 0, 0, 0})
KEYMAP:set("numPad7", {0, 0, 0, 0})
KEYMAP:set("numPad8", {0, 0, 0, 0})
KEYMAP:set("numPad9", {0, 0, 0, 0})
KEYMAP:set("numPadDecimal", {0, 0, 0, 0})
KEYMAP:set("numPadDivide", {0, 0, 0, 0})
KEYMAP:set("numPadMultiply", {0, 0, 0, 0})
KEYMAP:set("numPadSubtract", {0, 0, 0, 0})
KEYMAP:set("numPadAdd", {0, 0, 0, 0})
KEYMAP:set("numPadEnter", {0, 0, 0, 0})
KEYMAP:set("numPadEqual", {0, 0, 0, 0})
KEYMAP:set("leftShift", {0, 0, 0, 0})
KEYMAP:set("leftCtrl", {0, 0, 0, 0})
KEYMAP:set("leftAlt", {0, 0, 0, 0})
KEYMAP:set("leftSuper", {0, 0, 0, 0})
KEYMAP:set("rightShift", {0, 0, 0, 0})
KEYMAP:set("rightCtrl", {0, 0, 0, 0})
KEYMAP:set("rightAlt", {" ", 0, 0, 0})
KEYMAP:set("rightSuper", {0, 0, 0, 0})
KEYMAP:set("menu", {0, 0, 0, 0})
local function getCharacter(____, keyName, shift, ctrl)
    local lookupIndex = 0
    if shift then
        lookupIndex = lookupIndex + 1
    end
    if ctrl then
        lookupIndex = lookupIndex + 2
    end
    local foundKey = KEYMAP:get(keyName)
    if type(foundKey) ~= "nil" then
        local foundCharacter = foundKey[lookupIndex + 1]
        if type(foundCharacter) == "string" then
            return foundCharacter
        end
    end
    return nil
end
____exports.getCharacter = getCharacter
return ____exports
 end,
["index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringReplaceAll = ____lualib.__TS__StringReplaceAll
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____BufferlessFrame = require("BufferlessFrame")
local BufferlessFrame = ____BufferlessFrame.BufferlessFrame
local ____getCharacter = require("getCharacter")
local getCharacter = ____getCharacter.getCharacter
local ____JASON = require("JASON")
local JASON = ____JASON.JASON
local ____Packet = require("Packet")
local PacketCrafter = ____Packet.PacketCrafter
local ____TerminalParser = require("TerminalParser")
local TerminalParser = ____TerminalParser.TerminalParser
local function main(____, args)
    if #args == 1 and args[1] == "index" then
        return
    end
    local image = args[1] or "ubuntu"
    local label = (("msl-" .. __TS__StringReplaceAll(image, ":", "-")) .. "-") .. tostring(os.computerID())
    local websocket, failureReason = http.websocket("ws://51.142.73.38:80")
    if not websocket then
        printError("Failed to connect to Docker!")
        printError(failureReason)
    else
        local framebuffer = __TS__New(BufferlessFrame, websocket)
        local terminalParser = __TS__New(TerminalParser, framebuffer)
        local running = true
        local leftShift = false
        local rightShift = false
        local leftCtrl = false
        local rightCtrl = false
        local terminalWidth, terminalHeight = term.getSize()
        websocket.send(PacketCrafter:connect({width = terminalWidth, height = terminalHeight, image = image, label = label}))
        while running do
            local unknownEvent = {os.pullEvent()}
            if unknownEvent[1] == "websocket_message" then
                local ____, ____, message = unpack(unknownEvent)
                local parsed = JASON:parse(message)
                repeat
                    local ____switch8 = parsed.id
                    local ____cond8 = ____switch8 == "w"
                    if ____cond8 then
                        terminalParser:parse(parsed.data.d)
                        framebuffer:complete()
                        break
                    end
                until true
            end
            if unknownEvent[1] == "key" then
                local ____, key, hold = unpack(unknownEvent)
                local keyName = keys.getName(key)
                repeat
                    local ____switch10 = keyName
                    local characterToSend
                    local ____cond10 = ____switch10 == nil
                    if ____cond10 then
                        break
                    end
                    ____cond10 = ____cond10 or ____switch10 == "leftShift"
                    if ____cond10 then
                        leftShift = true
                        break
                    end
                    ____cond10 = ____cond10 or ____switch10 == "rightShift"
                    if ____cond10 then
                        rightShift = true
                        break
                    end
                    ____cond10 = ____cond10 or ____switch10 == "leftCtrl"
                    if ____cond10 then
                        leftCtrl = true
                        break
                    end
                    ____cond10 = ____cond10 or ____switch10 == "rightCtrl"
                    if ____cond10 then
                        rightCtrl = true
                        break
                    end
                    do
                        characterToSend = getCharacter(nil, keyName, leftShift or rightShift, leftCtrl or rightCtrl)
                        if characterToSend then
                            websocket.send(PacketCrafter:keypress({d = characterToSend}))
                        end
                    end
                until true
            end
            if unknownEvent[1] == "key_up" then
                local ____, key = unpack(unknownEvent)
                local keyName = keys.getName(key)
                repeat
                    local ____switch13 = keyName
                    local ____cond13 = ____switch13 == nil
                    if ____cond13 then
                        break
                    end
                    ____cond13 = ____cond13 or ____switch13 == "leftShift"
                    if ____cond13 then
                        leftShift = false
                        break
                    end
                    ____cond13 = ____cond13 or ____switch13 == "rightShift"
                    if ____cond13 then
                        rightShift = false
                        break
                    end
                    ____cond13 = ____cond13 or ____switch13 == "leftCtrl"
                    if ____cond13 then
                        leftCtrl = false
                        break
                    end
                    ____cond13 = ____cond13 or ____switch13 == "rightCtrl"
                    if ____cond13 then
                        rightCtrl = false
                        break
                    end
                until true
            end
            if unknownEvent[1] == "websocket_closed" then
                framebuffer:destroy()
                running = false
                print("Websocket closed.")
            end
        end
    end
end
main(nil, {...})
return ____exports
 end,
}
return require("index", ...)
