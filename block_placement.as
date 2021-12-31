bool PlaceBlock(CGameEditorPluginMap@ map, string blockName, CGameEditorPluginMap::ECardinalDirections dir, int3 point)
{
    auto info = map.GetBlockModelFromName(blockName);
	
	if(!(map.GetBlock(point) is null) && (blockName != RD_TURN2 && blockName != RD_UP2) && (map.GetBlock(point).BlockModel.IdName == WALL_STRAIGHT || map.GetBlock(point).BlockModel.IdName == WALL_FULL))
	{
		ClearPath(map, point);
	}

    while (!map.IsEditorReadyForRequest) {
        yield();
    }

    return map.PlaceBlock(info, point, dir);
}

bool CanPlaceBlock(CGameEditorPluginMap@ map, string blockName, CGameEditorPluginMap::ECardinalDirections dir, int3 point)
{
	auto info = map.GetBlockModelFromName(blockName);

	if(!(map.GetBlock(point) is null) && (blockName != RD_TURN2 && blockName != RD_UP2) && (map.GetBlock(point).BlockModel.IdName == WALL_STRAIGHT || map.GetBlock(point).BlockModel.IdName == WALL_FULL))
	{
		return true;
	}

    while (!map.IsEditorReadyForRequest) {
        yield();
    }

    return map.CanPlaceBlock(info, point, dir, true, 0);
}

bool PlaceGhostBlock(CGameEditorPluginMap@ map, string blockName, CGameEditorPluginMap::ECardinalDirections dir, int3 point)
{
	auto info = map.GetBlockModelFromName(blockName);
	
    while (!map.IsEditorReadyForRequest) {
        yield();
    }

    return map.PlaceGhostBlock(info, point, dir);	
}

bool CanPlaceGhostBlock(CGameEditorPluginMap@ map, string blockName, CGameEditorPluginMap::ECardinalDirections dir, int3 point)
{
	auto info = map.GetBlockModelFromName(blockName);
	
    while (!map.IsEditorReadyForRequest) {
        yield();
    }

    return map.CanPlaceGhostBlock(info, point, dir);	
}

CGameEditorPluginMapConnectResults@ ConnectBlocks(CGameEditorPluginMap@ map, CGameCtnBlock@ eBlock, string nBlock)
{
	try
    {
		auto info = map.GetBlockModelFromName(nBlock);

		while (!map.IsEditorReadyForRequest) {
			yield();
		}
		map.GetConnectResults(eBlock, info);
		
		while (!map.IsEditorReadyForRequest) {
			yield();
		}
		
		if (map.ConnectResults.Length > 0 && !(map.ConnectResults[map.ConnectResults.Length-1] is null))
		{
			return map.ConnectResults[map.ConnectResults.Length-1];
		}
		return null;
    }
    catch
    {
		return null;
    }
}

void ClearPath(CGameEditorPluginMap@ map, int3 point)
{
	TGprint("removing a wall from " + tostring(point));
	while (!map.IsEditorReadyForRequest) {
		yield();
	}
	map.RemoveBlock(point);
	
	auto upPoint = point.opAdd(int3(0,1,0));
	if(!(map.GetBlock(upPoint) is null) && (map.GetBlock(upPoint).BlockModel.IdName == WALL_STRAIGHT || map.GetBlock(upPoint).BlockModel.IdName == WALL_FULL))
	{
		while (!map.IsEditorReadyForRequest) {
			yield();
		}
		map.RemoveBlock(upPoint);
	}
}