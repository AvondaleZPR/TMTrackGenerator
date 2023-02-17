int blockCountBefore = -1;
int blockCountAfter = -1;

void BeginScenery()
{
	uint64 before = Time::get_Now();

	//preparing
	auto app = cast<CTrackMania>(GetApp());
	if (app is null) {
		return;
	}
		
	auto editor = cast<CGameCtnEditorFree>(app.Editor);
	if (editor is null) {
		UI::ShowNotification("editor is not opened!");
		warn("editor is not opened!");
		return;
	}
	
	auto map = cast<CGameEditorPluginMap>(editor.PluginMapType);
	if (map is null) {
		return;
	}

	auto blocks = GetApp().RootMap.Blocks;
	blockCountBefore = blocks.Length;
	//--
	
	TGprint("\\$0f0\\$sGenerating scenery!");
	
	for(int blockId = 0; blockId < blocks.Length; blockId++) 
	{
		string blockName = blocks[blockId].BlockModel.IdName;
		if (blockName != "Grass" && !blockName.Contains("TrackWall"))
		{
			TGprint("Generating scenery near " + blockName + " block");
			
			auto dir = RandomDirection();
			auto point = int3(blocks[blockId].CoordX, blocks[blockId].CoordY, blocks[blockId].CoordZ).opAdd(MoveDir(dir));
			
			string sceneryBlockName = RandomSceneryBlock();
			dir = RandomDirection();
			
			if(randomcolors)
			{
				map.NextMapElemColor = RandomColor();
			}
			
			int randHeight = Math::Rand(-1,4);
			if(CanPlaceBlock(map, sceneryBlockName, dir, point) && CanPlaceBlock(map, sceneryBlockName, dir, point.opAdd(int3(0, randHeight, 0))))
			{
				point = point.opAdd(int3(0, randHeight, 0));
				PlaceBlock(map, sceneryBlockName, dir, point);
				if(map.GetBlock(point.opAdd(int3(0, -1, 0))) is null)
				{
					while (!map.IsEditorReadyForRequest) {
						yield();
					}
					map.RemoveBlock(point);
				}
				else
				{
					TGprint("Placed " + sceneryBlockName + " scenery block!");
					
					if (sceneryBlockName.Contains("Screen"))
					{
						map.SetBlockSkin(map.GetBlock(point), SCREEN_LINK);
					}
					if (sceneryBlockName.Contains("Light"))
					{
						//map.SetBlockSkin(map.GetBlock(point), "Red");
					}					
				}
			}
			else
			{
				if(Math::Rand(1, 3) == 2)
				{
					blockId--;
				}
			}
		}
	}
	
	blockCountAfter = GetApp().RootMap.Blocks.Length;
	print("\\$0f0\\$sScenery generated in "+ tostring(Time::get_Now() - before) + " milliseconds!");
}

void CancelScenery()
{
	//--
	auto app = cast<CTrackMania>(GetApp());
	if (app is null) {
		return;
	}
		
	auto editor = cast<CGameCtnEditorFree>(app.Editor);
	if (editor is null) {
		UI::ShowNotification("editor is not opened!");
		warn("editor is not opened!");
		return;
	}
	
	auto map = cast<CGameEditorPluginMap>(editor.PluginMapType);
	if (map is null) {
		return;
	}

	auto blocks = GetApp().RootMap.Blocks;
	//--

	if (blockCountBefore == -1)
	{
		return;
	}

	for(int blockId = blockCountAfter-1; blockId > blockCountBefore-1; blockId--) 
	{
		auto point = int3(blocks[blockId].CoordX, blocks[blockId].CoordY, blocks[blockId].CoordZ);
		
		while (!map.IsEditorReadyForRequest) {
			yield();
		}
		map.RemoveBlock(point);
	}
	
	blockCountBefore = -1;
	blockCountAfter = -1;
}