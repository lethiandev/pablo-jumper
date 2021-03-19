extends Reference

var duration: float = 0.0
var frequency: float = 0.0

var samples: PoolRealArray = PoolRealArray()

func next(p_duration: float, p_frequency: float) -> void:
	duration = p_duration
	frequency = p_frequency
	_randomize_samples()

func amplitude_at(p_ticks: float) -> float:
	if duration <= p_ticks:
		return 0.0
	
	var s = p_ticks * frequency
	var s0 = floor(s)
	var s1 = s0 + 1.0
	
	var decay = _decay(p_ticks)
	
	var start = _noise(s0)
	var length = _noise(s1) - start
	var offset = (s - s0) * length
	
	return (start + offset) * decay

func _noise(p_index: float) -> float:
	var index = int(p_index)
	var limit = samples.size()
	return samples[index] if index < limit else 0.0

func _decay(p_ticks: float) -> float:
	var decay_at = (duration - p_ticks) / duration
	return decay_at if p_ticks < duration else 0.0

func _randomize_samples() -> void:
	var sample_count = int(duration * frequency)
	samples.resize(sample_count)
	for i in range(sample_count):
		samples[i] = randf() * 2.0 - 1.0
