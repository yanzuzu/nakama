local nk = require("nakama")

local function AuthenticateDeviceAfter(context, out_payload, in_payload )
    -- check the account is new or not
    if out_payload.created then
        local collectionKey = "Recipe"
        local storageKeyList = {"Hamburger","Salad","Soup","Cake","Stew","Noodle"}
        local user_id = context.user_id
        local new_objects = {}
        for index, value in ipairs(storageKeyList) do
            local initRecipe = {["id"] = value, ["level"] = 5, ["count"] = 50 , ["unlock_dish"] = {} }
            local storageObject = {collection = collectionKey, key = value,  user_id = user_id, value = initRecipe}
            table.insert(new_objects, storageObject)
        end
        nk.storage_write(new_objects)
    end
end

nk.register_req_after(AuthenticateDeviceAfter, "AuthenticateDevice")