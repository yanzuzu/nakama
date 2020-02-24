local nk = require("nakama")

local function http_request(context, payload)
    if  not context.user_id then
        error("Invalid")
    end
    return nk.json_decode(payload)
end

local function GetRecipe( context, payload )
    local request = http_request(context,payload)

    local result = {}
    local recipeResult = {}
    local records , cursor = nk.storage_list(context.user_id ,"Recipe", request.limit, request.cursor)
    for _, r in ipairs(records)
    do
        local recipeData = {["id"] = r.value.id, ["level"] = r.value.level, ["count"] = r.value.count}
        table.insert(recipeResult, recipeData)
    end
    result = {["Datas"] = recipeResult , ["Cursor"] = cursor}
    return nk.json_encode(result)

end

nk.register_rpc(GetRecipe, "recipe.getList")