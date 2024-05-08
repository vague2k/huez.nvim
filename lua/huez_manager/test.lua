
---NOTE: running this code will add the nightfox theme to the selected lists
---and reload the file making it available in the colorscheme list

-- require("huez_manager.selected").live_add("nightfox")
-- require("huez_manager.selected").lazy_flush()

--NOTE: This code will do the opposite of the above code
--Note, it doesnt remove it in the current session but it will remove it from the
--next session

require("huez_manager.selected").live_remove("nightfox")
require("huez_manager.selected").lazy_flush()
