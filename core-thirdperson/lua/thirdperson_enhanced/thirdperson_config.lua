if CLIENT then

	CreateClientConVar("thirdperson_etp", 							0, 		true, true)
	CreateClientConVar("thirdperson_etp_headpos", 					0, 		true, true)
	CreateClientConVar("thirdperson_etp_offset_x",					-40.0, 	true, true)
	CreateClientConVar("thirdperson_etp_offset_y",					20.0, 	true, true)
	CreateClientConVar("thirdperson_etp_offset_z", 					0.0, 	true, true)
	CreateClientConVar("thirdperson_etp_angle_x", 					0.0, 	true, true)
	CreateClientConVar("thirdperson_etp_angle_y", 					0.0, 	true, true)
	CreateClientConVar("thirdperson_etp_angle_z", 					0.0, 	true, true)
	CreateClientConVar("thirdperson_etp_fov", 						75, 	true, true)
	CreateClientConVar("thirdperson_etp_smoothing", 				0, 		true, true)
	CreateClientConVar("thirdperson_etp_smoothing_speed",			60.0, 	true, true)
	CreateClientConVar("thirdperson_etp_bind", 						0, 		true, true)
	CreateClientConVar("thirdperson_etp_aim", 						1, 		true, true)
	CreateClientConVar("thirdperson_etp_crouchadd", 				25, 	true, true)
	CreateClientConVar("thirdperson_etp_crosshair", 				1, 		true, true)
	CreateClientConVar("thirdperson_etp_crosshair_dot", 			1, 		true, true)
	CreateClientConVar("thirdperson_etp_crosshair_gap", 			1.0, 	true, true)
	CreateClientConVar("thirdperson_etp_crosshair_r", 				255, 	true, true)
	CreateClientConVar("thirdperson_etp_crosshair_g", 				255, 	true, true)
	CreateClientConVar("thirdperson_etp_crosshair_b", 				255, 	true, true)
	CreateClientConVar("thirdperson_etp_crosshair_alpha", 			255, 	true, true)
	CreateClientConVar("thirdperson_etp_crosshair_size", 			1.0, 	true, true)
	CreateClientConVar("thirdperson_etp_crosshair_outline", 		1, 		true, true)
	CreateClientConVar("thirdperson_etp_crosshair_outline_r", 		0, 		true, true)
	CreateClientConVar("thirdperson_etp_crosshair_outline_g", 		0, 		true, true)
	CreateClientConVar("thirdperson_etp_crosshair_outline_b", 		0, 		true, true)
	CreateClientConVar("thirdperson_etp_crosshair_outline_alpha", 	255, 	true, true)
	CreateClientConVar("thirdperson_etp_crosshair_style", 			0, 		true, true)
	CreateClientConVar("thirdperson_etp_vehicles_sync", 			1,		true, true)
	CreateClientConVar("thirdperson_etp_addons_sync", 				1,		true, true)
	
	language.Add( "Thirdperson", "Thirdperson" )

	hook.Add("PopulateToolMenu", "ThirdpersonSandboxMenu", function()
		spawnmenu.AddToolMenuOption("Utilities", "User", "thirdperson_etp_options", "Thirdperson", "", "", function(panel)
			panel:SetName("Thirdperson")
			panel:AddControl("Header", {
				Text = "",
				Description = "Configuration menu for the Thirdperson."
			})
			
			local ConVarsDefault = {
				
			}

			panel:AddControl("ComboBox", {
				MenuButton = 1,
				Folder = "EnhancedThirdperson",
				Options = {
					[ "#preset.default" ] = {
						thirdperson_etp = "0",
						thirdperson_etp_headpos = "0",
						thirdperson_etp_bind = "0",
						thirdperson_etp_offset_x = "-40.0",
						thirdperson_etp_offset_y = "20.0",
						thirdperson_etp_offset_z = "0.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "75",
						thirdperson_etp_smoothing = "0",
						thirdperson_etp_smoothing_speed = "60.0",
						thirdperson_etp_crosshair = "0",
						thirdperson_etp_crosshair_style = "0",
						thirdperson_etp_crosshair_dot = "1",
						thirdperson_etp_crosshair_gap = "1.0",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "255",
						thirdperson_etp_crosshair_b = "255",
						thirdperson_etp_crosshair_alpha = "255",
						thirdperson_etp_crosshair_size = "1.0",
						thirdperson_etp_crosshair_outline = "0",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					},
					[ "GTA V/Max Payne 3" ] = {
						thirdperson_etp = "1",
						thirdperson_etp_headpos = "0",
						thirdperson_etp_bind = "0",
						thirdperson_etp_offset_x = "-100.0",
						thirdperson_etp_offset_y = "35.0",
						thirdperson_etp_offset_z = "0.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "85",
						thirdperson_etp_smoothing = "0",
						thirdperson_etp_smoothing_speed = "60.0",
						thirdperson_etp_crosshair = "1",
						thirdperson_etp_crosshair_style = "0",
						thirdperson_etp_crosshair_dot = "1",
						thirdperson_etp_crosshair_gap = "1.0",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "255",
						thirdperson_etp_crosshair_b = "255",
						thirdperson_etp_crosshair_alpha = "255",
						thirdperson_etp_crosshair_size = "1.0",
						thirdperson_etp_crosshair_outline = "1",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					}, 
					[ "GTA IV" ] = {
						thirdperson_etp = "1",
						thirdperson_etp_headpos = "0",
						thirdperson_etp_bind = "0",
						thirdperson_etp_offset_x = "-100.0",
						thirdperson_etp_offset_y = "35.0",
						thirdperson_etp_offset_z = "0.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "80",
						thirdperson_etp_smoothing = "0",
						thirdperson_etp_smoothing_speed = "60.0",
						thirdperson_etp_crosshair = "1",
						thirdperson_etp_crosshair_style = "1",
						thirdperson_etp_crosshair_dot = "1",
						thirdperson_etp_crosshair_gap = "1.5",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "255",
						thirdperson_etp_crosshair_b = "255",
						thirdperson_etp_crosshair_alpha = "25",
						thirdperson_etp_crosshair_size = "1.0",
						thirdperson_etp_crosshair_outline = "0",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					}, 
					[ "GTA IV TLAD" ] = {
						thirdperson_etp = "1",
						thirdperson_etp_headpos = "0",
						thirdperson_etp_bind = "0",
						thirdperson_etp_offset_x = "-100.0",
						thirdperson_etp_offset_y = "35.0",
						thirdperson_etp_offset_z = "0.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "80",
						thirdperson_etp_smoothing = "0",
						thirdperson_etp_smoothing_speed = "60.0",
						thirdperson_etp_crosshair = "1",
						thirdperson_etp_crosshair_style = "1",
						thirdperson_etp_crosshair_dot = "1",
						thirdperson_etp_crosshair_gap = "1.5",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "135",
						thirdperson_etp_crosshair_b = "135",
						thirdperson_etp_crosshair_alpha = "25",
						thirdperson_etp_crosshair_size = "1.0",
						thirdperson_etp_crosshair_outline = "0",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					},
					[ "GTA IV TBOGT" ] = {
						thirdperson_etp = "1",
						thirdperson_etp_headpos = "0",
						thirdperson_etp_bind = "0",
						thirdperson_etp_offset_x = "-100.0",
						thirdperson_etp_offset_y = "35.0",
						thirdperson_etp_offset_z = "0.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "80",
						thirdperson_etp_smoothing = "0",
						thirdperson_etp_smoothing_speed = "60.0",
						thirdperson_etp_crosshair = "1",
						thirdperson_etp_crosshair_style = "1",
						thirdperson_etp_crosshair_dot = "1",
						thirdperson_etp_crosshair_gap = "1.5",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "135",
						thirdperson_etp_crosshair_b = "225",
						thirdperson_etp_crosshair_alpha = "25",
						thirdperson_etp_crosshair_size = "1.0",
						thirdperson_etp_crosshair_outline = "0",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					},
					[ "Saints Row/Just Cause" ] = {
						thirdperson_etp = "1",
						thirdperson_etp_headpos = "0",
						thirdperson_etp_bind = "0",
						thirdperson_etp_offset_x = "-100.0",
						thirdperson_etp_offset_y = "35.0",
						thirdperson_etp_offset_z = "0.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "80",
						thirdperson_etp_smoothing = "0",
						thirdperson_etp_smoothing_speed = "60.0",
						thirdperson_etp_crosshair = "1",
						thirdperson_etp_crosshair_style = "2",
						thirdperson_etp_crosshair_dot = "0",
						thirdperson_etp_crosshair_gap = "1.5",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "255",
						thirdperson_etp_crosshair_b = "255",
						thirdperson_etp_crosshair_alpha = "255",
						thirdperson_etp_crosshair_size = "2.0",
						thirdperson_etp_crosshair_outline = "1",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					},
					[ "Machinima" ] = {
						thirdperson_etp = "1",
						thirdperson_etp_headpos = "0",
						thirdperson_etp_bind = "0",
						thirdperson_etp_offset_x = "-200.0",
						thirdperson_etp_offset_y = "0.0",
						thirdperson_etp_offset_z = "0.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "35",
						thirdperson_etp_smoothing = "1",
						thirdperson_etp_smoothing_speed = "5.0",
						thirdperson_etp_crosshair = "1",
						thirdperson_etp_crosshair_style = "0",
						thirdperson_etp_crosshair_dot = "0",
						thirdperson_etp_crosshair_gap = "1.0",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "255",
						thirdperson_etp_crosshair_b = "255",
						thirdperson_etp_crosshair_alpha = "255",
						thirdperson_etp_crosshair_size = "1.0",
						thirdperson_etp_crosshair_outline = "0",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					},
					[ "Minecraft" ] = {
						thirdperson_etp = "1",
						thirdperson_etp_headpos = "0",
						thirdperson_etp_bind = "93",
						thirdperson_etp_offset_x = "-150.00",
						thirdperson_etp_offset_y = "0.0",
						thirdperson_etp_offset_z = "20.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "75",
						thirdperson_etp_smoothing = "0",
						thirdperson_etp_smoothing_speed = "100.0",
						thirdperson_etp_crosshair = "1",
						thirdperson_etp_crosshair_style = "2",
						thirdperson_etp_crosshair_dot = "0",
						thirdperson_etp_crosshair_gap = "0.0",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "255",
						thirdperson_etp_crosshair_b = "255",
						thirdperson_etp_crosshair_alpha = "255",
						thirdperson_etp_crosshair_size = "3.0",
						thirdperson_etp_crosshair_outline = "0",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					},
					[ "Mass Effect" ] = {
						thirdperson_etp = "1",
						thirdperson_etp_headpos = "0",
						thirdperson_etp_bind = "0",
						thirdperson_etp_offset_x = "-50.0",
						thirdperson_etp_offset_y = "20.0",
						thirdperson_etp_offset_z = "0.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "75",
						thirdperson_etp_smoothing = "0",
						thirdperson_etp_smoothing_speed = "60.0",
						thirdperson_etp_crosshair = "1",
						thirdperson_etp_crosshair_style = "1",
						thirdperson_etp_crosshair_dot = "0",
						thirdperson_etp_crosshair_gap = "2.0",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "160",
						thirdperson_etp_crosshair_b = "0",
						thirdperson_etp_crosshair_alpha = "65",
						thirdperson_etp_crosshair_size = "2.0",
						thirdperson_etp_crosshair_outline = "0",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					},
					[ "Firstperson" ] = {
						thirdperson_etp = "1",
						thirdperson_etp_headpos = "1",
						thirdperson_etp_bind = "0",
						thirdperson_etp_offset_x = "5.0",
						thirdperson_etp_offset_y = "0.0",
						thirdperson_etp_offset_z = "0.0",
						thirdperson_etp_angle_x = "0.0",
						thirdperson_etp_angle_y = "0.0",
						thirdperson_etp_angle_z = "0.0",
						thirdperson_etp_aim = "1",
						thirdperson_etp_fov = "85",
						thirdperson_etp_smoothing = "0",
						thirdperson_etp_smoothing_speed = "100.0",
						thirdperson_etp_crosshair = "1",
						thirdperson_etp_crosshair_style = "2",
						thirdperson_etp_crosshair_dot = "0",
						thirdperson_etp_crosshair_gap = "1.0",
						thirdperson_etp_crosshair_r = "255",
						thirdperson_etp_crosshair_g = "255",
						thirdperson_etp_crosshair_b = "255",
						thirdperson_etp_crosshair_alpha = "255",
						thirdperson_etp_crosshair_size = "1.0",
						thirdperson_etp_crosshair_outline = "0",
						thirdperson_etp_crosshair_outline_r = "0",
						thirdperson_etp_crosshair_outline_g = "0",
						thirdperson_etp_crosshair_outline_b = "0",
						thirdperson_etp_crosshair_outline_alpha = "255",
						thirdperson_etp_vehicles_sync = "1",
						thirdperson_etp_addons_sync = "1"
					}
				},
				CVars = {}
			})

			panel:AddControl("Checkbox", {
				Label = "Enable",
				Command = "thirdperson_etp"
			})

			panel:AddControl("Checkbox", {
				Label = "Use Head Position",
				Command = "thirdperson_etp_headpos"
			})

			panel:AddControl("Checkbox", {
				Label = "Use Sync for Default Vehicle",
				Command = "thirdperson_etp_vehicles_sync"
			})

			panel:AddControl("Checkbox", {
				Label = "Use Sync for Addons",
				Command = "thirdperson_etp_addons_sync"
			})

			panel:AddControl("Numpad", {
				Label = "Set the Bind-Key",
				Command = "thirdperson_etp_bind"
			})

			panel:AddControl("Slider", {
				Type = "float",
				Label = "Offset X",
				Command = "thirdperson_etp_offset_x",
				Min = -150.0,
				Max = 150.0
			})

			panel:AddControl("Slider", {
				Type = "float",
				Label = "Offset Y",
				Command = "thirdperson_etp_offset_y",
				Min = -150.0,
				Max = 150.0
			})

			panel:AddControl("Slider", {
				Type = "float",
				Label = "Offset Z",
				Command = "thirdperson_etp_offset_z",
				Min = -150.0,
				Max = 150.0
			})

			panel:AddControl("Checkbox", {
				Label = "Enable Aiming",
				Command = "thirdperson_etp_aim"
			})
			
			panel:ControlHelp("If disable - Manual control angle")

			panel:AddControl("Slider", {
				Type = "float",
				Label = "Angle X",
				Command = "thirdperson_etp_angle_x",
				Min = 0.0,
				Max = 360.0
			})

			panel:AddControl("Slider", {
				Type = "float",
				Label = "Angle Y",
				Command = "thirdperson_etp_angle_y",
				Min = 0.0,
				Max = 360.0
			})

			panel:AddControl("Slider", {
				Type = "float",
				Label = "Angle Z",
				Command = "thirdperson_etp_angle_z",
				Min = 0.0,
				Max = 360.0
			})

			panel:AddControl("Slider", {
				Label = "FOV",
				Command = "thirdperson_etp_fov",
				Min = 25,
				Max = 100
			})
			
			panel:AddControl("Checkbox", {
				Label = "Smooth Camera Moving",
				Command = "thirdperson_etp_smoothing",
			})
			
			panel:AddControl("Slider", {
				Type = "float",
				Label = "Speed Smooth Camera",
				Command = "thirdperson_etp_smoothing_speed",
				Min = 0.0,
				Max = 100.0
			})

			panel:AddControl("Checkbox", {
				Label = "Use Custom Crosshair",
				Command = "thirdperson_etp_crosshair"
			})
			
			panel:AddControl("Checkbox", {
				Label = "Use Crosshair Dot",
				Command = "thirdperson_etp_crosshair_dot"
			})
			
			panel:AddControl( "ComboBox", {
				Label = "Crosshair Style",
				Options = {
					["Nothing"]		= { thirdperson_etp_crosshair_style = "0" },
					["Cone"]		= { thirdperson_etp_crosshair_style = "1" },
					["Lines"]		= { thirdperson_etp_crosshair_style = "2" }
				}
			})
			
			panel:AddControl("Slider", {
				Type = "float",
				Label = "Сrosshair Gap Scale",
				Command = "thirdperson_etp_crosshair_gap",
				Min = 0.0,
				Max = 2.0
			})

			panel:AddControl("Slider", {
				Type = "float",
				Label = "Сrosshair Size",
				Command = "thirdperson_etp_crosshair_size",
				Min = 1.0,
				Max = 3.0
			})

			panel:AddControl( "Color", {
				Label = "Crosshair Color",
				Red = "thirdperson_etp_crosshair_r",
				Green = "thirdperson_etp_crosshair_g",
				Blue = "thirdperson_etp_crosshair_b",
				Alpha = "thirdperson_etp_crosshair_alpha"
			})

			panel:AddControl("Checkbox", {
				Label = "Crosshair Outline",
				Command = "thirdperson_etp_crosshair_outline"
			})

			panel:AddControl( "Color", {
				Label = "Сrosshair Outline Color",
				Red = "thirdperson_etp_crosshair_outline_r",
				Green = "thirdperson_etp_crosshair_outline_g",
				Blue = "thirdperson_etp_crosshair_outline_b",
				Alpha = "thirdperson_etp_crosshair_outline_alpha"
			})
		end)
	end)
	
end