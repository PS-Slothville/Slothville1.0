-- Permissions System
InternalPermissions = {}

--- Gets a player's permission group. If the player is not in the permissions table, it will return "user".
---@param src string | number The player's source.
---@return string group The player's permission group.
InternalPermissions.GetPermissionGroup = function(src)
    ---@cast src string
    local license = GetPlayerIdentifierByType(src, "license")
    local group = "user"
    local result = MySQL.Sync.fetchAll("SELECT * FROM permissions WHERE license = @license", {["@license"] = license})
    if result[1] then
        group = result[1].group
        print("[SLOTHVILLE] Logging in staff member: " .. GetPlayerName(src) .. " (" .. license .. ") as " .. group)
    end
    return group
end
exports("GetPermissionGroup", InternalPermissions.GetPermissionGroup)

--- Sets a player's permission group. If the group is "user", it will remove the player from the permissions table.
---@param src string | number The player's source.
---@param group string  The player's permission group.
InternalPermissions.SetPermissionGroup = function(src, group)
    ---@cast src string
    local license = GetPlayerIdentifierByType(src, "license")
    if group == "user" then
        MySQL.Sync.execute("DELETE FROM permissions WHERE license = @license", {["@license"] = license})
        return
    end

    local result = MySQL.Sync.fetchAll("SELECT * FROM permissions WHERE license = @license", {["@license"] = license})
    if result[1] then
        MySQL.Sync.execute("UPDATE permissions SET `group` = @group WHERE license = @license", {["@license"] = license, ["@group"] = group})
    else
        MySQL.Sync.execute("INSERT INTO permissions (`license`, `group`) VALUES (@license, @group)", {["@license"] = license, ["@group"] = group})
    end
end
exports("SetPermissionGroup", InternalPermissions.SetPermissionGroup)