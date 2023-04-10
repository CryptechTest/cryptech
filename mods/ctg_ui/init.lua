local bg = "bg_emoji.png"

local form = "size[10,7.8] bgcolor[#333444cc; false] image_button_exit[0,0;2,2;" ..
bg ..
"^1_emoji.png;1_emoji;] image_button_exit[2,0;2,2;" ..
bg ..
"^2_emoji.png;2_emoji;] image_button_exit[4,0;2,2;" ..
bg ..
"^3_emoji.png;3_emoji;] image_button_exit[6,0;2,2;" ..
bg ..
"^4_emoji.png;4_emoji;] image_button_exit[8,0;2,2;" ..
bg ..
"^5_emoji.png;5_emoji;] image_button_exit[0,2;2,2;" ..
bg ..
"^6_emoji.png;6_emoji;] image_button_exit[2,2;2,2;" ..
bg ..
"^7_emoji.png;7_emoji;] image_button_exit[4,2;2,2;" ..
bg ..
"^8_emoji.png;8_emoji;] image_button_exit[6,2;2,2;" ..
bg ..
"^9_emoji.png;9_emoji;] image_button_exit[8,2;2,2;" ..
bg ..
"^10_emoji.png;10_emoji;] image_button_exit[0,4;2,2;" ..
bg ..
"^11_emoji.png;11_emoji;] image_button_exit[2,4;2,2;" ..
bg ..
"^12_emoji.png;12_emoji;] image_button_exit[4,4;2,2;" ..
bg ..
"^13_emoji.png;13_emoji;] image_button_exit[6,4;2,2;" ..
bg ..
"^14_emoji.png;14_emoji;] image_button_exit[8,4;2,2;" ..
bg ..
"^15_emoji.png;15_emoji;] image_button_exit[0,6;2,2;" ..
bg ..
"^16_emoji.png;16_emoji;] image_button_exit[2,6;2,2;" ..
bg ..
"^17_emoji.png;17_emoji;] image_button_exit[4,6;2,2;" ..
bg ..
"^18_emoji.png;18_emoji;] image_button_exit[6,6;2,2;" ..
bg .. "^19_emoji.png;19_emoji;] image_button_exit[8,6;2,2;" .. bg .. "^20_emoji.png;20_emoji;]"


unified_inventory.register_button("emoji", {
    type = "image",
    image = "1_emoji.png",
    tooltip = S("Emoji"),
    action = function(player)
        minetest.show_formspec(player:get_player_name(), "emoji_form", form)
    end
})
