void TGprint(const string str)
{
	if(st_debug)
	{
		print(str);
	}
}

bool CanDisplay()
{
	if (cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor) is null) {
		warn("editor is not opened!");
		return false;
	}

	return true;
}


void LoadMapSize()
{
	auto app = cast<CTrackMania>(GetApp());
	if (app is null) {
		return;
	}
		
	auto editor = cast<CGameCtnEditorFree>(app.Editor);
	if (editor is null) {
		return;
	}
	
	auto map = cast<CGameEditorPluginMap>(editor.PluginMapType);
	if (map is null) {
		return;
	}
	
	MAX_X = map.Map.Size.x;
	MAX_Y = map.Map.Size.y - 2;
	MAX_Z = map.Map.Size.z;
}