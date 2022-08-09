class X2Item_AlienBossWeaponsSchematics extends X2Item config(StrategyTuning);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Schematics;

	Schematics.AddItem(CreateTemplate_PARulers_BoltCaster_CV_Schematic());
	Schematics.AddItem(CreateTemplate_PARulers_BoltCaster_MG_Schematic());
	Schematics.AddItem(CreateTemplate_PARulers_BoltCaster_BM_Schematic());
	
	return Schematics;
}

static function X2DataTemplate CreateTemplate_PARulers_BoltCaster_CV_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'PARulers_BoltCaster_CV_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_DLC2Images.ConvBoltCaster";
	Template.PointsToComplete = 0;
	Template.Tier = 0;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.GiveItems;
	Template.bSquadUpgrade = false;

	// Items to Reward
	Template.ItemRewards.AddItem('PARulers_BoltCaster_CV');
	Template.ReferenceItemTemplate = 'PARulers_BoltCaster_CV';

	// Requirements
	Template.Requirements.SpecialRequirementsFn = PA_Rulers_AreConventionalHunterWeaponsAvailable;
	Template.Requirements.RequiredTechs.AddItem('PA_ViperKing_Tech');


	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 35;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTemplate_PARulers_BoltCaster_MG_Schematic()
{
	local X2SchematicTemplate Template;
	local StrategyRequirement AltReq;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'PARulers_BoltCaster_MG_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_DLC2Images.MagBoltCaster";
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;
	Template.bSquadUpgrade = false;

	// Reference Item
	Template.ReferenceItemTemplate = 'PARulers_BoltCaster_MG';

	// Narrative Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	Template.Requirements.RequiredTechs.AddItem('PA_ViperKing_Tech');
	Template.Requirements.RequiredEquipment.AddItem('PARulers_BoltCaster_CV');
	Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = PA_Rulers_IsAlienHuntersNarrativeContentComplete;
	
	// Non-Narrative Requirements
	AltReq.RequiredItems.AddItem('PARulers_BoltCaster_CV');
	AltReq.RequiredTechs.AddItem('MagnetizedWeapons');
	AltReq.RequiredEngineeringScore = 10;
	AltReq.bVisibleIfPersonnelGatesNotMet = true;
	Template.AlternateRequirements.AddItem(AltReq);

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 60;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTemplate_PARulers_BoltCaster_BM_Schematic()
{
	local X2SchematicTemplate Template;
	local StrategyRequirement AltReq;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'PARulers_BoltCaster_BM_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_DLC2Images.BeamBoltCaster";
	Template.PointsToComplete = 0;
	Template.Tier = 3;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;
	Template.bSquadUpgrade = false;

	// Reference Item
	Template.ReferenceItemTemplate = 'PARulers_BoltCaster_BM';

	// Narrative Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	Template.Requirements.RequiredTechs.AddItem('PA_ViperKing_Tech');
	Template.Requirements.RequiredEquipment.AddItem('PARulers_BoltCaster_MG');
	Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = PA_Rulers_IsAlienHuntersNarrativeContentComplete;

	// Non-Narrative Requirements
	AltReq.RequiredEquipment.AddItem('PARulers_BoltCaster_MG');
	AltReq.RequiredTechs.AddItem('PlasmaRifle');
	AltReq.RequiredEngineeringScore = 20;
	AltReq.bVisibleIfPersonnelGatesNotMet = true;
	Template.AlternateRequirements.AddItem(AltReq);

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 125;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = 15;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function bool PA_Rulers_IsAlienHuntersNarrativeContentComplete()
{
	local XComGameState_CampaignSettings CampaignSettings;

	CampaignSettings = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings'));

	if (CampaignSettings.HasOptionalNarrativeDLCEnabled(name(class'X2DownloadableContentInfo_DLC_Day60'.default.DLCIdentifier)))
	{
		if (class'XComGameState_HeadquartersXCom'.static.IsObjectiveCompleted('DLC_AlienNestMissionComplete'))
		{
			return true;
		}
	}

	return false;
}

static function bool PA_Rulers_AreConventionalHunterWeaponsAvailable()
{
    local XComGameState_HeadquartersXCom XcomHQ;

    XcomHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

    if (XcomHQ.EverAcquiredInventoryTypes.Find('AlienHunterRifle_CV') != INDEX_NONE )
    {
        return true;
    }

    return false;
}