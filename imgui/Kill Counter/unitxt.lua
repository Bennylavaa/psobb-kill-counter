-- Author: Soleil Rojas (https://github.com/Solybum)
-- From: PSOBBMod-Addons (https://github.com/Solybum/PSOBBMod-Addons)
-- License: GPL-3.0 (https://github.com/Solybum/PSOBBMod-Addons/blob/master/LICENSE)

unitxtPointer = 0x00A9CD50
unitxtItemName = 0x04
unitxtMonsterName = 0x08
unitxtItemDesc = 0x0C
unitxtMonsterNameUlt = 0x10

local ReadInternal = function(group, index)
    local str
    
    address = pso.read_u32(unitxtPointer)
    if address == 0 then
        return nil
    end
    
    address = address + group
    address = pso.read_u32(address)
    if address == 0 then
        return nil
    end
    
    address = address + 4 * index
    address = pso.read_u32(address)
    if address == 0 then
        return nil
    end
    
    str = pso.read_wstr(address, 256)
    return str
end

function Read(group, index)
    str = ReadInternal(group, index)
    return str
end
function ReadItemName(index)
    return ReadInternal(unitxtItemName, index)
end
function ReadItemDescription(index)
    return ReadInternal(unitxtItemDesc, index)
end
function ReadMonsterName(index, difficulty)
    difficulty = difficulty or 0
    if difficulty == 3 then
        return ReadInternal(unitxtMonsterNameUlt, index)
    else
        return ReadInternal(unitxtMonsterName, index)
    end
end

return
{
    Read = Read,
    ReadItemName = ReadItemName,
    ReadItemDescription = ReadItemDescription,
    ReadMonsterName = ReadMonsterName,
}
