class_name PortraitVideoPlayer
extends VideoStreamPlayer

var _resource_manager: ResourceManager
var _current_dat_unit: DatUnit
var talking := false
var talking_video_list: Array[String]
var idle_video_list: Array[String]

@onready var portrait_audio_player: AudioStreamPlayer = $PortraitAudioPlayer

func _ready() -> void:
	portrait_audio_player.finished.connect(_on_portrait_audio_player_finished)
	finished.connect(_on_portrait_video_player_finished)

func _init_resources(resource_manager: ResourceManager):
	_resource_manager = resource_manager

func play_portrait(dat_unit: DatUnit):
	_current_dat_unit = dat_unit
	var sound_obj = dat_unit.ready_sound_obj()
	if sound_obj == null:
		# unit has no ready sound
		return
	
	var sound_path = sound_obj.sound_file_tbl().name1()
		
	# sound
	sound_path = sound_path.replace("\\", "/")
	sound_path = sound_path.to_lower() # the filenames are converted lowercase, but in tbl resource not, so lower it
	sound_path = sound_path.trim_suffix(".wav")
	sound_path += ".ogg"
	sound_path = _resource_manager.starts_resources_path + "sounds/" + sound_path
	
	portrait_audio_player.stream = AudioStreamOggVorbis.load_from_file(sound_path)
	portrait_audio_player.play()
	
	# video
	var talking_video_path = dat_unit.portrait_obj().video_talking_tbl().name1()
	talking_video_list = find_portrait_videos(talking_video_path)
	
	var idle_video_path = dat_unit.portrait_obj().video_idle_tbl().name1()
	idle_video_list = find_portrait_videos(idle_video_path)
	
	talking = true
	start_talking()

func start_talking():
	var video_stream_theora = VideoStreamTheora.new()
	video_stream_theora.file = talking_video_list.pick_random() # TODO: implement later real change_idle/talking random
	stream = video_stream_theora
	play()
	
func start_idle():
	talking = false
	var video_stream_theora = VideoStreamTheora.new()
	video_stream_theora.file = idle_video_list.pick_random() # TODO: implement later real change_idle/talking random
	stream = video_stream_theora
	play()
	
func find_portrait_videos(video_base_path: String) -> Array[String]:
	video_base_path = video_base_path.replace("\\", "/")
	video_base_path = video_base_path.to_lower() # the filenames are converted lowercase, but in tbl resource not, so lower it
	
	var i: int = 0
	var video_list: Array[String] = []
	while true:
		var video_full_path = video_base_path + str(i) + ".ogv"
		video_full_path = _resource_manager.starts_resources_path + "portraits/" + video_full_path
		if FileAccess.file_exists(video_full_path):
			video_list.push_back(video_full_path)
		else:
			break
		i += 1
	return video_list

func _on_portrait_audio_player_finished():
	talking = false


func _on_portrait_video_player_finished():
	if talking:
		start_talking()
	else:
		start_idle()
