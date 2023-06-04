class_name NfStopwatch
## A class for stopwatch in microseconds.
##
## Version: 1.1.0
## [codeblock]
## var sw = NfStopwatch.new()
## #
## # Example 1
## #
## sw.start()
## sw.stop()
## print(sw.float_total_time())
## #
## # Example 2
## #
## sw.start()
## sw.record_lap()
## print(sw.int_lap_time("usec"))
## sw.record_lap()
## print(sw.int_lap_time("usec"))
## for lap in sw.lap_range():
##     print("%d:%f" % [lap, sw.float_split_time("msec", lap)])
## [/codeblock]
##
## @tutorial: https://github.com/nekofleet/nf-class-collection


#-------------------------------------------------------------------------------
# Main variables
#-------------------------------------------------------------------------------
var _split_time: Array[int] = [0]


#-------------------------------------------------------------------------------
# Methods for operation
#-------------------------------------------------------------------------------
## Starts the stopwatch.
func start() -> void:
	_split_time = [Time.get_ticks_usec()]


## Records a lap time.
func record_lap() -> void:
	_split_time.append(Time.get_ticks_usec())


## Stops the stopwatch.
func stop() -> void:
	record_lap()


#-------------------------------------------------------------------------------
# Methods for lap range
#-------------------------------------------------------------------------------
## Returns the number of the laps.
func lap_count() -> int:
	return _split_time.size() - 1


## Returns the array of the laps.
func lap_range() -> Array:
	return range(1, lap_count()+1)


func _get_valid_lap(lap: int) -> int:
	if lap_count() == 0:
		return 0
	if lap == -1:
		lap = lap_count()

	if lap < 1 or lap_count() < lap:
		return 0
	else:
		return lap


#-------------------------------------------------------------------------------
# Methods for lap_time
#-------------------------------------------------------------------------------
## Returns the float lap time in the unit.[br]
## unit: [code]"sec"[/code] or [code]"msec"[/code] or [code]"usec"[/code].[br]
## lap: [code]-1[/code] is the last lap.
func float_lap_time(unit: String = "sec", lap: int = -1) -> float:
	lap = _get_valid_lap(lap)
	if lap == 0:
		return 0.0

	var t = _split_time[lap] - _split_time[lap-1]
	match unit:
		"sec":
			return float(t) / (1000.0*1000.0)
		"msec":
			return float(t) / 1000.0
		_:
			return float(t)


## Returns the int lap time in the unit.[br]
## unit: [code]"sec"[/code] or [code]"msec"[/code] or [code]"usec"[/code].[br]
## lap: [code]-1[/code] is the last lap.
func int_lap_time(unit: String = "sec", lap: int = -1) -> int:
	lap = _get_valid_lap(lap)
	if lap == 0:
		return 0

	var t = _split_time[lap] - _split_time[lap-1]
	match unit:
		"sec":
			return int(float(t) / (1000.0*1000.0))
		"msec":
			return int(float(t) / 1000.0)
		_:
			return t


#-------------------------------------------------------------------------------
# Methods for split_time
#-------------------------------------------------------------------------------
## Returns the float split time in the unit.[br]
## unit: [code]"sec"[/code] or [code]"msec"[/code] or [code]"usec"[/code].[br]
## lap: [code]-1[/code] is the last lap.
func float_split_time(unit: String = "sec", lap: int = -1) -> float:
	lap = _get_valid_lap(lap)
	if lap == 0:
		return 0.0

	var t = _split_time[lap] - _split_time[0]
	match unit:
		"sec":
			return float(t) / (1000.0*1000.0)
		"msec":
			return float(t) / 1000.0
		_:
			return float(t)


## Returns the int split time in the unit.[br]
## unit: [code]"sec"[/code] or [code]"msec"[/code] or [code]"usec"[/code].[br]
## lap: [code]-1[/code] is the last lap.
func int_split_time(unit: String = "sec", lap: int = -1) -> int:
	lap = _get_valid_lap(lap)
	if lap == 0:
		return 0

	var t = _split_time[lap] - _split_time[0]
	match unit:
		"sec":
			return int(float(t) / (1000.0*1000.0))
		"msec":
			return int(float(t) / 1000.0)
		_:
			return t


#-------------------------------------------------------------------------------
# Methods for total_time
#-------------------------------------------------------------------------------
## Returns the float total time in the unit.[br]
## unit: [code]"sec"[/code] or [code]"msec"[/code] or [code]"usec"[/code].
func float_total_time(unit: String = "sec") -> float:
	return float_split_time(unit, -1)


## Returns the int total time in the unit.[br]
## unit: [code]"sec"[/code] or [code]"msec"[/code] or [code]"usec"[/code].
func int_total_time(unit: String = "sec") -> int:
	return int_split_time(unit, -1)


#-------------------------------------------------------------------------------
# Methods for current_time
#-------------------------------------------------------------------------------
## Returns the float current time in the unit.[br]
## unit: [code]"sec"[/code] or [code]"msec"[/code] or [code]"usec"[/code].
func float_current_time(unit: String = "sec") -> float:
	var t = Time.get_ticks_usec() - _split_time[0]
	match unit:
		"sec":
			return float(t) / (1000.0*1000.0)
		"msec":
			return float(t) / 1000.0
		_:
			return float(t)


## Returns the int current time in the unit.[br]
## unit: [code]"sec"[/code] or [code]"msec"[/code] or [code]"usec"[/code].
func int_current_time(unit: String = "sec") -> int:
	var t = Time.get_ticks_usec() - _split_time[0]
	match unit:
		"sec":
			return int(float(t) / (1000.0*1000.0))
		"msec":
			return int(float(t) / 1000.0)
		_:
			return t


#-------------------------------------------------------------------------------
# Methods for short version
#-------------------------------------------------------------------------------
## Same as float_lap_time("sec", lap).
func lap_time(lap: int = -1) -> float:
	return float_lap_time("sec", lap)


## Same as float_split_time("sec", lap).
func split_time(lap: int = -1) -> float:
	return float_split_time("sec", lap)


## Same as float_total_time("sec").
func total_time() -> float:
	return float_total_time("sec")


## Same as float_current_time("sec").
func current_time() -> float:
	return float_current_time("sec")
