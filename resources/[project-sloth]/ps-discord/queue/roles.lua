-- Role(s) that are allowed to go through the queue, you may leave it empty if you want everyone in your server to be able to join
local allowlistedRoles = {
    "1180766253879672862"
}

-- Put in what priority their Discord role should have, the higher they are on the list the higher priority they have.
local priorityRoles = {
    "1180765952552480829",
    "1180765873921851513",
    "1180766057745612851",
}

return {
    allowlistedRoles = allowlistedRoles,
    priorityRoles = priorityRoles
}
