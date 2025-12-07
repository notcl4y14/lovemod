return {
	_NAME = "Basic Swords",

	LoadItems = function(self, item_api)
		item_api.AddItem(self, {
			name = "Wooden Sword",
			type = "Weapon",
		})
		item_api.AddItem(self, {
			name = "Stone Sword",
			type = "Weapon",
		})
		item_api.AddItem(self, {
			name = "Iron Sword",
			type = "Weapon",
		})
		item_api.AddItem(self, {
			name = "Silver Sword",
			type = "Weapon",
		})
	end
}
