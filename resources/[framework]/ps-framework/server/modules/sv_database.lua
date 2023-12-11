InternalDatabase = {}
InternalDatabase.Tables = {
    {
        name = "characters",
        query = [[
            CREATE TABLE IF NOT EXISTS `characters` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `license` VARCHAR(255), 
                `cid` VARCHAR(12), 
                `slot` int(11),
                `charinfo` TEXT, 
                `skin` TEXT, 
                `job` TEXT, 
                `gang` TEXT, 
                `money` TEXT, 
                `metadata` TEXT, 
                `position` TEXT, 
                `inventory` longtext DEFAULT NULL,
                `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                PRIMARY KEY (`cid`),
                KEY `id` (`id`),
                KEY `last_updated` (`last_updated`),
                KEY `license` (`license`)
            ) ENGINE=InnoDB AUTO_INCREMENT=1;
        ]],
    },
    {
        name = "permissions",
        query = [[
            CREATE TABLE IF NOT EXISTS `permissions` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `license` VARCHAR(255), 
                `group` VARCHAR(12), 
                PRIMARY KEY (`license`),
                KEY `id` (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=1;
        ]],
    },
    { 
        name = "outfits",
        query = [[
            CREATE TABLE IF NOT EXISTS `outfits` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `cid` varchar(50) DEFAULT NULL,
                `outfitname` varchar(50) NOT NULL,
                `skin` text DEFAULT NULL,
                `outfitId` varchar(50) NOT NULL,
                PRIMARY KEY (`id`),
                KEY `cid` (`cid`),
                KEY `outfitId` (`outfitId`)
            ) ENGINE=InnoDB AUTO_INCREMENT=1;
        ]],
    },
    {
        name = "inventory_stashes",
        query = [[
            CREATE TABLE IF NOT EXISTS `inventory_stashes` (
                `owner` varchar(60) DEFAULT NULL,
                `name` varchar(100) NOT NULL,
                `data` longtext DEFAULT NULL,
                `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                UNIQUE KEY `owner` (`owner`,`name`)
            );
        ]],
    },
    {
        name = "players",
        query = [[
            CREATE TABLE IF NOT EXISTS `players` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `license` VARCHAR(255), 
                `slothid` VARCHAR(50), 
                PRIMARY KEY (`license`),
                UNIQUE KEY `slothid` (`slothid`),
                KEY `id` (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=1;
        ]],
    },
}

CreateThread(function()
    MySQL.ready(function()
        for _,table in pairs(InternalDatabase.Tables) do
            MySQL.Async.execute(table.query, {}, function()
                print(("Slothville: Database table %s initialized"):format(table.name))
            end)
        end
    end)
end)