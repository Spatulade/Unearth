extends Node
onready var oDataClm = Nodelist.list["oDataClm"]
onready var oDataClmPos = Nodelist.list["oDataClmPos"]
onready var oDataLevelStyle = Nodelist.list["oDataLevelStyle"]
onready var oDataOwnership = Nodelist.list["oDataOwnership"]
onready var oDataSlab = Nodelist.list["oDataSlab"]
onready var oOverheadOwnership = Nodelist.list["oOverheadOwnership"]
onready var oGenerateTerrain = Nodelist.list["oGenerateTerrain"]
onready var oEditor = Nodelist.list["oEditor"]
onready var oOverheadGraphics = Nodelist.list["oOverheadGraphics"]
onready var oOpenMap = Nodelist.list["oOpenMap"]
onready var oGame = Nodelist.list["oGame"]
onready var oUiTools = Nodelist.list["oUiTools"]
onready var oDataWibble = Nodelist.list["oDataWibble"]
onready var oDataSlx = Nodelist.list["oDataSlx"]
onready var oDataLiquid = Nodelist.list["oDataLiquid"]
onready var oDataMapName = Nodelist.list["oDataMapName"]
onready var oMain = Nodelist.list["oMain"]
onready var oMessage = Nodelist.list["oMessage"]
onready var oDataScript = Nodelist.list["oDataScript"]
onready var oScriptHelpers = Nodelist.list["oScriptHelpers"]
onready var oDataFakeSlab = Nodelist.list["oDataFakeSlab"]
onready var oSlabPlacement = Nodelist.list["oSlabPlacement"]
onready var oMenu = Nodelist.list["oMenu"]
onready var oDataLof = Nodelist.list["oDataLof"]
onready var oInstances = Nodelist.list["oInstances"]
onready var oColumnEditor = Nodelist.list["oColumnEditor"]

var path = ""
var currentFilePaths = {} # [0] = pathString,  [1] = modified date

enum {
	PATHSTRING
	MODIFIED_DATE
}

func _init():
	OS.set_window_title('Unearth v'+Version.full)

func _on_ButtonNewMap_pressed():
	oOpenMap.open_map("") # This means "blank" map


func set_path_and_title(newpath):
	if newpath != "":
		OS.set_window_title(newpath + ' - Unearth v'+Version.full)
		oMenu.add_recent(newpath) # Add saved maps to the recent menu
	else:
		OS.set_window_title('Unearth v'+Version.full)
	path = newpath
	
	oGame.reconstruct_command_line() # Always update command line whenever the path changes

func clear_map():
	var CODETIME_START = OS.get_ticks_msec()
	
	var allInst = get_tree().get_nodes_in_group("Instance")
	for id in allInst:
		oInstances.kill_instance(id)
	
	# "lif"
	oDataMapName.clear()
	# "wib"
	oDataSlx.clear_img()
	oOverheadOwnership.clear()
	# "inf"
	oDataLevelStyle.data = 0
	# 3D
	oGenerateTerrain.clear()
	#"TXT"
	oDataScript.data = ""
	
	oScriptHelpers.clear()
	
	# "LOF" # Do this last in case other functions rely on the old map size
	oDataLof.clear_all()
	
	Things.LIST_OF_SPELLBOOKS.clear()
	Things.LIST_OF_HEROGATES.clear()
	
	if oColumnEditor.visible == true:
		oColumnEditor.visible = false
	
	print('Cleared map in '+str(OS.get_ticks_msec()-CODETIME_START)+'ms')

