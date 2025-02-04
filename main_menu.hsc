; Globals
(global short ui_location -1)
(global short currentCharacter -1)
(global boolean never_end false)

; Externs

; Scripts
(script startup void mainmenu
	(print "mainmenu startup script")
	(set currentCharacter (ui_get_player_model_id))
	(wake appearance_characters)
	(fade_out 0 0 0 0)
	(sleep 8)
	(fade_in 0 0 0 22)
	(camera_control true)
	(ring_loop)
)

(script static void kill_camera_scripts
	(print "kill camera scripts")
	(kill_active_scripts)
	(if (!= ui_location 0)
		(sleep_forever ring_loop)
	)
	(if (!= ui_location 1)
		(sleep_forever settings_cam)
	)
)

(script static void (set_ui_location (short location))
	(set ui_location location)
	(sleep 1)
)

(script static void ring_loop
	(set ui_location 0)
	(kill_camera_scripts)
	(sleep_until
		(begin
			(camera_set "point_1" 400)
			(sleep 200)
			(camera_set "point_2" 400)
			(sleep 200)
			(camera_set "point_3" 400)
			(sleep 200)
			(camera_set "point_4" 400)
			(sleep 200)
			(camera_set "point_5" 400)
			(sleep 200)
			(camera_set "point_6" 400)
			(sleep 200)
			(camera_set "point_7" 400)
			(sleep 200)
			(camera_set "point_8" 400)
			(sleep 200)
			(camera_set "point_9" 400)
			(sleep 200)
			(camera_set "point_10" 400)
			(sleep 200)
			(camera_set "point_11" 400)
			(sleep 200)
			never_end
		)
	1)
)

(script dormant void appearance_characters
	(print "appearance characters [dormant script]")
	(sleep 1)
	(objects_attach "spartan_appearance" "right_hand" "appearance_ar" "invalid")
	(objects_attach "elite_appearance" "right_hand_elite" "appearance_pr" "invalid")
	(custom_animation_loop "spartan_appearance" "objects\characters\masterchief\masterchief" "ui:rifle:idle:var1" false)
	(custom_animation_loop "elite_appearance" "objects\characters\dervish\dervish" "ui:pistol:idle:var1" false)
	(object_hide "spartan_appearance" true)
	(object_hide "elite_appearance" true)
)

(script static void settings_cam
	(print "settings cam")
	(set_ui_location 1)
	(kill_camera_scripts)
	(render_depth_of_field_enable false)
	(object_hide "elite_appearance" false)
	(object_hide "spartan_appearance" false)
	(camera_set "settings_cam" -1)
)

(script static void leave_settings
	(print "leave settings")
	(object_hide "spartan_appearance" true)
	(object_hide "elite_appearance" true)
	(ring_loop)
)

(script static void character_changed
	(sleep 1)
	(set currentCharacter (ui_get_player_model_id))
	(effect_new_on_object_marker "objects\characters\elite\fx\shield\shield_recharge" "elite_appearance" "body")
	(effect_new_on_object_marker "objects\characters\masterchief\fx\shield\shield_recharge" "spartan_appearance" "body")
)