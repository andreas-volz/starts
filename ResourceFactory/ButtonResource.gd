class_name ButtonResource
extends Resource

enum FunctionType { 
	REQ_FUNCTION, 
	ACT_FUNCTION, 
	STATUS_FUNCTION, 
	DISPLAY_FUNCTION 
}

enum Category {
	UNIT,
	UNIT_EXT,
	TECH,
	UPGRADE,
	GENERIC,
}

enum ReqFunction {
	ALWAYS,  # Always
	IN_CONSTRUCTING_HALF_SCV,  # In Constructing (Half - SCV)
	HAS_NO_EXIT,  # Has No Exit
	BURROWED_STOP_LURKER,  # Burrowed (Stop - Lurker)
	NOT_BURROWED_MOVE_STOP_PATROL_HOLD_POSITION,  # Not Burrowed(Move/Stop/Patrol/Hold Position)
	BUILDING_HAS_LIFTED_OFF,  # Building Has Lifted Off
	BUILDING_CAN_MOVE_AND_HAS_LIFTED_OFF,  # Building Can Move And Has Lifted Off
	RECHARGE_SHIELDS,  # Recharge Shields
	UNIT_IS_CARRYING_SOMETHING_RETURN_CARGO_PROBE,  # Unit Is Carrying Something (Return Cargo - Probe)
	UNIT_IS_CARRYING_NOTHING_GATHER_PROBE,  # Unit Is Carrying Nothing (Gather - Probe)
	CONSTRUCTION_MUTATION_UNDERWAY,  # Construction/Mutation Underway
	LARVA_EXIST_UPGRADING_ONLY,  # Larva Exist(Upgrading Only)
	CANCEL_LAST,  # Cancel Last
	RETURN_CARGO_SCV,  # Return Cargo (SCV)
	GATHER_SCV,  # Gather (SCV)
	REPAIR_SCV,  # Repair (SCV)
	ATTACK_SCV,  # Attack (SCV)
	STOP_SCV,  # Stop (SCV)
	MOVE_SCV,  # Move (SCV)
	HAS_SCARABS,  # Has Scarabs
	HAS_INTERCEPTORS,  # Has interceptors
	HAS_CARGO_RETURN_CARGO_DRONE,  # Has Cargo (Return Cargo - Drone)
	HAS_NO_CARGO_GATHER_DRONE,  # Has No Cargo (Gather - Drone)
	BUILDING_HAS_LANDED,  # Building Has Landed
	NUKE_AVAILABLE,  # Nuke Available
	TANK_IS_IN_TANK_MODE_MOVE,  # Tank Is in Tank Mode(Move)
	RESEARCH_UNDERWAY,  # Research Underway
	UPGRADE_UNDERWAY,  # Upgrade Underway
	CANCEL_ADDON,  # Cancel AddOn
	NUKE_TRAIN,  # Nuke Train
	TERRAN_ADVANCED_BUILDINGS,  # Terran Advanced Buildings
	TERRAN_BASIC_BUILDINGS,  # Terran Basic Buildings
	PROTOSS_ADVANCED_BUILDINGS,  # Protoss Advanced Buildings
	PROTOSS_BASIC_BUILDINGS,  # Protoss Basic Buildings
	ZERG_ADVANCED_BUILDINGS,  # Zerg Advanced Buildings
	ZERG_BASIC_BUILDINGS,  # Zerg Basic Buildings
	MIXED_GROUP_STOP,  # Mixed Group - Stop
	MIXED_GROUP_MOVE_PATROL_HOLD_POSITION,  # Mixed Group - Move/Patrol/Hold Position
	CAN_BUILD_SUBUNIT,  # Can Build Subunit
	CAN_CREATE_UNIT_BUILDING,  # Can Create Unit/Building
	CARRYING_SOME_UNITS,  # Carrying Some Units
	ATTACKING_BUILDING,  # Attacking Building
	UNIT_HAS_A_WEAPON,  # Unit Has A Weapon
	NOT_BURROWED_ATTACK,  # Not Burrowed (Attack)
	UNITS_CAPACITY_HAS_BEEN_MET,  # Unit's Capacity Has Been Met
	IS_USING_ABILITY,  # Is Using Ability
	ABILITY_IS_RESEARCHED,  # Ability Is Researched
	TANK_IS_IN_SIEGE_MODE,  # Tank Is in Siege Mode
	TANK_IS_IN_TANK_MODE,  # Tank Is in Tank Mode
	CAN_DECLOAK_MIXED,  # Can Decloak - Mixed
	CAN_CLOAK_MIXED,  # Can Cloak - Mixed
	CAN_DECLOAK,  # Can Decloak
	CAN_CLOAK,  # Can Cloak
	UPGRADE_NOT_AT_MAX_LEVEL,  # Upgrade Not At Max Level
	HAS_SPIDERMINE_AND_IS_RESEARCHED,  # Has Spidermine and Is Researched
	SPELL_RESEARCHED,  # Spell Researched
	TECH_SPELL_NOT_RESEARCHED,  # Tech Spell Not Researched
	RALLY_POINT,  # Rally Point
	TWO_UNITS_SELECTED_DARK_ARCHON_MELD,  # 2 Units Selected (Dark Archon Meld)
	TWO_UNITS_SELECTED_NOT_RESEARCHED_DARK_ARCHON_MELD,  # 2 Units Selected & Not Researched(Dark Archon Meld)
	UNITS_SELECTED_2_ARCHON_WARP,  # 2 Units Selected (Archon Warp)
	UNITS_SELECTED_2_NOT_RESEARCHED_ARCHON_MERGE,  # 2 Units Selected & Not Researched(Archon Merge)
	MORPH_TO_LURKER,  # Morph To Lurker
	RALLY_POINT_WHILE_UPGRADING_ONLY,  # Rally Point - While Upgrading Only
	PLAY_PAUSE_REPLAY,  # Play/Pause Replay
	SPEED_UP_REPLAY,  # Speed Up Replay
	SLOW_DOWN_REPLAY  # Slow Down Replay
}

enum ReqAction {
	CANCEL_INFESTATION, # Cancel Infestation
	CANCEL_NUCLEAR_STRIKE, # Cancel Nuclear Strike
	DARK_ARCHON_WARP, # Dark Archon Warp
	ARCHON_WARP, # Archon Warp
	LIFT_OFF, # Lift Off
	DECLOAK, # Decloak
	UNBURROW, # Unburrow
	BURROW, # Burrow
	CANCEL_ADDON, # Cancel AddOn
	CANCEL_UPGRADE_RESEARCH, # Cancel Upgrade Research
	RESEARCH_UPGRADE, # Research Upgrade
	CANCEL_TECHNOLOGY_RESEARCH, # Cancel Technology Research
	RESEARCH_TECHNOLOGY, # Research Technology
	HOLD_POSITION, # Hold Position
	BUILD_SUBUNIT, # Build Subunit
	STOP_REAVER, # Stop Reaver
	STOP_CARRIER, # Stop Carrier
	STOP, # Stop
	CANCEL_MORPH, # Cancel Morph
	CANCEL_CONSTRUCTION, # Cancel Construction
	SIEGE_MODE, # Siege Mode
	TANK_MODE, # Tank Mode
	CANCEL_LAST, # Cancel Last
	CREATE_UNIT, # Create Unit
	STIMPACK, # StimPack
	CLOAK, # Cloak
	RETURN_CARGO, # Return Cargo
	UNIT_MORPH, # Unit Morph
	BUILDING_MORPH, # Building Morph
	SELECT_LARVA, # Select Larva
	HEAL, # Heal
	NUCLEAR_STRIKE, # Nuclear Strike
	RECHARGE_SHIELDS, # Recharge Shields
	UNLOAD, # Unload
	LOAD, # Load
	GATHER, # Gather
	REPAIR, # Repair
	LAND, # Land
	PLACE_NYDUS_CANAL_EXIT, # Place Nydus Canal Exit
	CREATE_BUILDING_ZERG, # Create Building - Zerg
	CREATE_ADDON, # Create AddOn
	CREATE_BUILDING_PROTOSS, # Create Building - Protoss
	PLACE_COP, # Place COP
	CREATE_BUILDING_TERRAN, # Create Building - Terran
	USE_TECHNOLOGY, # Use Technology
	PATROL, # Patrol
	ATTACK_REAVER, # Attack Reaver
	ATTACK_CARRIER, # Attack Carrier
	MOVE_CARRIER_REAVER, # Move (Carrier/Reaver)
	ATTACK_BUILDING, # Attack (Building)
	ATTACK_SUICIDE, # Attack (Suicide)
	ATTACK, # Attack
	MOVE, # Move
	RALLY_POINT, # Rally Point
	CANCEL, # Cancel
	CANCEL_PLACE_BUILDINGS, # Cancel Place Buildings
	CHANGE_DISPLAYED_BUTTONS, # Change Displayed Buttons
	SPEED_UP_REPLAY, # Speed Up Replay
	PLAY_PAUSE_REPLAY, # Play/Pause Replay
	SLOW_DOWN_REPLAY, # Slow Down Replay
}

@export var list: Array
