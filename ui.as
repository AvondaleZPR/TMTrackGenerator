//vars
bool display = false, preloaded = false;
int st_maxBlocks = 45;
//--

void RenderMenu()
{
	if (UI::MenuItem("\\$f00" + Icons::Random + "\\$fff Track Generator")) {	
		if (cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor) is null) {
			warn("editor is not opened!");
			return;
		}
		
		display = !display;
	}
}

void RenderInterface()
{
	if(!display)
	{
		return;
	}
	
	UI::SetNextWindowSize(686, 635);
	UI::SetNextWindowPos(300, 300, UI::Cond::Once);
	
	UI::Begin("Track Generator", display, UI::WindowFlags::NoResize);	
	if (UI::Button(Icons::Random + " Generate Random Track")) {
		Begin();
	}
	UI::SameLine();
	if (UI::Button(Icons::Download + " Preload Blocks")) {
		Preload();
	}
	UI::SameLine();
	if (UI::Button(Icons::Trash + " Clear Map")) {
		Undo();
	}
	if(!preloaded) {UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle +" It is recommended to preload the blocks before generating a track.");}
	
	UI::Separator();
	UI::Markdown("**Block Count**");
	st_maxBlocks = UI::SliderInt("\\$bbb(excluding start and finish)", st_maxBlocks, 5, 150);
	UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle +" Generated track doesn't always have the exact number of blocks, because Track Generator");
	UI::Text("\\$ff0\\$sisn't perfect and it can get stuck. In that case Track Generator will just try to place the finish block.");
	
	UI::Separator();
	UI::Markdown("**Block Style**");
	roadblocks = UI::Checkbox("Tech Road", roadblocks);
	if (roadblocks) {TechBlocks();}
	UI::SameLine();
	dirtblocks = UI::Checkbox("Dirt Road", dirtblocks);
	if (dirtblocks) {DirtBlocks();}
	UI::SameLine();
	iceblocks = UI::Checkbox("Ice Road", iceblocks);
	if (iceblocks) {IceBlocks();}
	UI::SameLine();
	icewallblocks = UI::Checkbox("Ice Road With Wall", icewallblocks);
	if (icewallblocks) {IceWallBlocks();}
	UI::SameLine();
	sausageblocks = UI::Checkbox("Sausage Road", sausageblocks);
	if (sausageblocks) {SausageBlocks();}	
	opentechroadblocks = UI::Checkbox("Platform Tech Road", opentechroadblocks);
	if (opentechroadblocks) {OpenTechRoadBlocks();}
	UI::SameLine();
	opendirtroadblocks = UI::Checkbox("Platform Dirt Road", opendirtroadblocks);
	if (opendirtroadblocks) {OpenDirtRoadBlocks();}
	UI::SameLine();
	openiceroadblocks = UI::Checkbox("Platform Ice Road", openiceroadblocks);
	if (openiceroadblocks) {OpenIceRoadBlocks();}
	UI::SameLine();
	opengrassroadblocks = UI::Checkbox("Platform Grass Road", opengrassroadblocks);
	if (opengrassroadblocks) {OpenGrassRoadBlocks();}
	waterblocks = UI::Checkbox("HALO AM ANDA DA WATA", waterblocks);
	if (waterblocks) {WaterBlocks();}
	
	/*
	if(IsMultipleBlockTypesSelected()) {
		UI::Text("\\$ff0\\$s" + Icons::ExclamationTriangle +" Using  multiple styles will sometimes (like 1/20) cause Generator to get stuck at building the track.");
		UI::Text("\\$ff0\\$sHopefully i will figure out the reasons and fix it in the next versions.");
	}
	*/
	
	UI::Separator();
	UI::Markdown("**Seed**");
	UI::Text("\\$sTrack will be generated from this text. Same text with same settings will generate same track every time.");
	UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle + " Max 10 characters!");
	seedEnabled = UI::Checkbox("Enable", seedEnabled); UI::SameLine();
	bool changed = false;
	UI::Text("\\$080\\$s" + Icons::Key + " Seed:"); UI::SameLine();
	seedText = UI::InputText("", seedText, changed, UI::InputTextFlags::CharsUppercase);
	seedText = seedText.SubStr(0, 10);
	if (changed && seedEnabled) {
		if(seedText.get_Length() > 0)
		{
			seedDouble = ConvertSeed(seedText);
		}
		else
		{
			seedEnabled = false;
		}
	}
	UI::Separator();
	
	UI::Markdown("**Special Blocks**");
	UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle + " Some of those blocks can make track unbeatable.");
	turbo1 = UI::Checkbox("Turbo", turbo1); UI::SameLine();
	turbo2 = UI::Checkbox("Super Turbo", turbo2); UI::SameLine();
	turbor = UI::Checkbox("Turbo R", turbor); UI::SameLine();
	booster1 = UI::Checkbox("Reactor Boost", booster1); UI::SameLine();
	booster2 = UI::Checkbox("Super Reactor Boost", booster2); UI::SameLine();
	noengine = UI::Checkbox("\\$ff0Engine Off", noengine); 
	reset = UI::Checkbox("Reset Block", reset); UI::SameLine();
	slowmotion = UI::Checkbox("Riolu Block", slowmotion); UI::SameLine();	
	fragile = UI::Checkbox("Fragile", fragile); UI::SameLine();	
	cruise = UI::Checkbox("Cruise", cruise); UI::SameLine();
	nobrake = UI::Checkbox("No Brakes", nobrake); UI::SameLine();
	nosteer = UI::Checkbox("\\$ff0No Steering", nosteer); 
	UI::Separator();
	
	/*
	UI::Markdown("**Items**");
	UI::Separator();
	*/
	
	UI::Markdown("**Other Options**");
	coolblocks = UI::Checkbox("Use cool blocks \\$bbb(Tech Ramps, Dirt Bumps, etc)", coolblocks); 
	randomcolors = UI::Checkbox("Paint blocks with random colors \\$bbb(Doesn't get affected by seed)", randomcolors);
	UI::Separator();
	
	UI::Text("\\$999\\$sTrack Generator " + Meta::GetPluginFromSiteID(156).get_Version() + " by \\$bbbAvondaleZPR \\$999" + Icons::Copyright);
	UI::End();
}

void Main()
{
	auto app = cast<CTrackMania>(GetApp());
	if(app is null)
	{
		return;
	}
	CGamePlayerInfo@ playerInfo = cast<CTrackManiaNetwork@>(app.Network).PlayerInfo;
	if(playerInfo is null)
	{
		return;
	}
	seedText = playerInfo.Name;
	seedText = seedText.ToUpper();
	
	TechBlocks();
}