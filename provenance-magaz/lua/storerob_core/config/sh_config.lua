
NPCRobSystem.Config = {}

-- If you run into any issues and the addon throws errors at you, contact me through a support ticket, or add me on steam.



-- NPC Model
NPCRobSystem.Config.NPCModel = "models/Humans/Group01/male_07.mdl"


-- NPC Text
NPCRobSystem.Config.NPCText = "Неизвестный"


-- The ULX groups that have access to the "savestorerob" command
NPCRobSystem.Config.SaveComGroup = {
    ["superadmin"] = true,
    ["root"] = true
}


-- The prefix in chat for the store actions
NPCRobSystem.Config.StorePrefix = "Продавец"


-- The color of the prefix in chat for the store actions
NPCRobSystem.Config.StorePrefixColor = Color( 210, 195, 20 )


-- The prefix in chat for the robbery actions
NPCRobSystem.Config.RobPrefix = "[?]"


-- The color of the prefix in chat for the robbery actions
NPCRobSystem.Config.RobPrefixColor = Color( 20, 195, 210 )


-- The font used throughout the addon
NPCRobSystem.Config.Font = "Roboto"




-- Should the store be robable?
NPCRobSystem.Config.RobberySystem = true
 

-- How much does the NPC get robbed for?
-- This can also be a function
NPCRobSystem.Config.RobAmount = 2000


-- The amount of time it takes to rob the NPC
NPCRobSystem.Config.RobTime = 20


-- The amount of time it takes for the store to be robable again
NPCRobSystem.Config.RobCoodownTime = 1300


-- What % of players need to be Government for the store to be robable? (Must be a decimal, e.g: 0.2 would be 20%)
NPCRobSystem.Config.RobGovernmentAmount = 0.2


-- How many players are needed on the server for the store to be robable?
NPCRobSystem.Config.RobPlayerAmount = 0


-- Max distance the robber is allowed away from the NPC while robbing it
NPCRobSystem.Config.RobMaxDistance = 500


-- How often does the npc call for help? Between 1 and x
NPCRobSystem.Config.RobShouttime = 45


-- This is the animation that is used while the NPC is being robbed
-- For a list of all the usable ainimations, go to: https://pastebin.com/7Ezumawk
NPCRobSystem.Config.RobActiveAni = "cower_Idle"


-- Should the NPC play an alarm while being robbed?
NPCRobSystem.Config.RobAlarmActive = true


-- This is the alarm sound that is used while the NPC is being robbed
-- For a list of all the usable sounds, go to: https://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index8f77.html
NPCRobSystem.Config.RobAlarmDir = "ambient/alarms/alarm1.wav"


-- Use the moneybag system? This system drops a money bag instead of giving it straight to the user
NPCRobSystem.Config.RobMoneybagSystem = true


-- The model of the "money bag" that will drop
NPCRobSystem.Config.RobMoneybagModel = "models/freeman/money_sack.mdl"


-- Should robberys be restricted to specific jobs?
NPCRobSystem.Config.CanRobSpec = true


-- What jobs can Rob the NPC?
NPCRobSystem.Config.CanRobJobs = {
    TEAM_THIEFF,
    TEAM_GANG
}


-- These are the jobs that are considered Government
NPCRobSystem.Config.ConsideredCops = {
    TEAM_POLICE
}

-- Should the user be forced to have a weapon out when entering a robbery?
NPCRobSystem.Config.ForceWeapon = false

-- If the above is true, what is considered a weapon? (class names)
NPCRobSystem.Config.ForceWeaponWeapons = {
    "mg_makarov",
    "mg_p320",
    "mg_glock"
}


-- The color of the buy button IF the player can afford it
NPCRobSystem.Config.ShopBuyColor = Color(70,70,70)


-- The color of the buy button IF the player cannot afford it
NPCRobSystem.Config.ShopBuyDenyColor = Color(200, 60, 60)


-- Should the store UI slide onto the screen?
NPCRobSystem.Config.AnimateUISlide = false


-- Should the store UI stay on screen once an item is purchased?
NPCRobSystem.Config.KeepUIOpen = false


-- Should unpurchasable items show? (They'll be red)
NPCRobSystem.Config.ShowUnpurchasable = true


-- Should the models rotate?
NPCRobSystem.Config.ShopModelRotate = true


-- These are the tabs that are used in the below table
NPCRobSystem.Config.ShopTabs = {
    [1] = { display = "Оружия",            tabcolor = Color(140,100,0) },
    [2] = { display = "Патроны",               tabcolor = Color(0,130,70)  },

}


-- name, this is the display name for the item
-- desc, this is the short description for the item
-- ent, this is the actual entity that will be spawned
-- price, this is the price for the item
-- model, this is the display model for the item
-- tabs, this is the tab the item will be under, use the tabs you defined above!
-- isWep, is the item a weapon? By having this true, it will give the item to the players weapon slots. If false, it will spawn on the ground
-- customCheck, is the item restriction system. Use this like you do DarkRP jobs
-- preSpawn, this allows you to edit the entity before it spawns (player, entity)
-- postSpawn, this allows you to edit the entity after it spawns (player, entity)

NPCRobSystem.Config.ShopContent = {
    [1] = { name = "Нож",desc = "Обычный охотничий нож.", ent = "swb_knife", price = 450, model = "models/weapons/w_crowbar.mdl", tab = "Оружия",    isWep = true	},
    [2] = { name = "Глок", desc = "Что ты собрался с этим делать?!", ent = "mg_glock", price = 8000, model = "models/weapons/w_pist_glock18.mdl", tab = "Оружия",    isWep = true	},
    [3] = { name = "Патроны для пистолета", desc = "", ent = "item_ammo_pistol", price = 250, model = "models/Items/ammocrate_smg1.mdl", tab = "Патроны",       isWep = false	},
    [4] = { name = "Патроны для револьвера", desc = "", ent = "item_ammo_357", price = 250, model = "models/Items/BoxBuckshot.mdl", tab = "Патроны", isWep = false	},
    
    
    
    

}   

