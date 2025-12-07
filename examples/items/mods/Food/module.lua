return {
	_NAME = "Food",

	LoadItems = function(self, item_api)
		item_api.AddItem(self, {
			name = "Apple",
			type = "Food",
		})
		item_api.AddItem(self, {
			name = "Water Bottle",
			type = "Food",
		})
		item_api.AddItem(self, {
			name = "Blackberry",
			type = "Food",
		})
		item_api.AddItem(self, {
			name = "Stew",
			type = "Food",
		})
		item_api.AddItem(self, {
			name = "Mushroom",
			type = "Food",
		})
		item_api.AddItem(self, {
			name = "Bread",
			type = "Food",
		})
	end
}
