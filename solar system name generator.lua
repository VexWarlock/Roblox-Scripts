local number = 10

local vowels = {"a","e","i","o","u","y"}
local consonants = {"b","c","d","f","g","h","j","k","l","m","n","p","r","s","t","v","w","x","z"}

local function GenerateNamePart()
    local length = math.random(5,10)
    local name = ""
    local useConsonant = math.random(0,1) == 1

    while #name < length do
        if useConsonant then
            name = name .. consonants[math.random(1, #consonants)]
        else
            name = name .. vowels[math.random(1, #vowels)]
        end
        useConsonant = not useConsonant
    end

    name = string.sub(name, 1, length)
    name = string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)
    return name
end

local function GenerateName()
    if math.random() < math.random(15, 27) / 100 then
        return GenerateNamePart() .. "'" .. GenerateNamePart()
    else
        return GenerateNamePart()
    end
end

local function GenerateMultipleNames(count)
    local names = {}
    for i = 1, count do
        table.insert(names, GenerateName())
    end
    return names
end

local solarSystemNames = GenerateMultipleNames(number)
for _, name in ipairs(solarSystemNames) do
    print(name)
end
