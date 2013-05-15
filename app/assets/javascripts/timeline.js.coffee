

@timelineUnits = [
  multiple: 30 # 30 min
  base: 60 * 1000
  major: 5 * 60 * 1000
  minor: 60 * 1000
,
  multiple: 1 # 1 hr
  base: 60 * 60 * 1000
  major: 5 * 60 * 1000
  minor: 60 * 1000
,
  multiple: 3 # 3 hr
  base: 60 * 60 * 1000
  major: 30 * 60 * 1000
  minor: 5 * 60 * 1000
,
  multiple: 6 # 6 hr
  base: 60 * 60 * 1000
  major: 30 * 60 * 1000
  minor: 5 * 60 * 1000
,
  multiple: 12 # 12 hr
  base: 60 * 60 * 1000
  major: 60 * 60 * 1000
  minor: 5 * 60 * 1000
,
  multiple: 1 # 1 day
  base: 24 * 60 * 60 * 1000
  major: 3 * 60 * 60 * 1000
  minor: 10 * 60 * 1000
,
  multiple: 3 # 3 day
  base: 24 * 60 * 60 * 1000
  major: 12 * 60 * 60 * 1000
  minor: 60 * 60 * 1000
,
  multiple: 6 # 6 day
  base: 24 * 60 * 60 * 1000
  major: 12 * 60 * 60 * 1000
  minor: 60 * 60 * 1000
,
  multiple: 12 # 12 day
  base: 24 * 60 * 60 * 1000
  major: 24 * 60 * 60 * 1000
  minor: 3 * 60 * 60 * 1000
,
  multiple: 1 # 1 month
  base: 31 * 24 * 60 * 60 * 1000
  major: 7 * 24 * 60 * 60 * 1000
  minor: 6 * 60 * 60 * 1000
,
  multiple: 3 # 3 month
  base: 31 * 24 * 60 * 60 * 1000
  major: 14 * 24 * 60 * 60 * 1000
  minor: 12 * 60 * 60 * 1000
,
  multiple: 6 # 6 month
  base: 31 * 24 * 60 * 60 * 1000
  major: 1
  minor: 24 * 60 * 60 * 1000
,
  multiple: 1 # 1 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 1
  minor: 3 * 24 * 60 * 60 * 1000
,
  multiple: 3 # 3 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 2
  minor: 7 * 24 * 60 * 60 * 1000
,
  multiple: 5 # 5 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 2
  minor: 14 * 24 * 60 * 60 * 1000
,
  multiple: 10 # 10 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 365 * 24 * 60 * 60 * 1000
  minor: 30 * 24 * 60 * 60 * 1000
,
  multiple: 25 # 25 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 5 * 365 * 24 * 60 * 60 * 1000
  minor: (365 / 5) * 24 * 60 * 60 * 1000
,
  multiple: 50 # 50 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 10 * 365 * 24 * 60 * 60 * 1000
  minor: (365 / 3) * 24 * 60 * 60 * 1000
,
  multiple: 100 # 100 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 10 * 365 * 24 * 60 * 60 * 1000
  minor: 365 * 24 * 60 * 60 * 1000
,
  multiple: 300 # 300 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 50 * 365 * 24 * 60 * 60 * 1000
  minor: 3 * 365 * 24 * 60 * 60 * 1000
,
  multiple: 500 # 500 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 50 * 365 * 24 * 60 * 60 * 1000
  minor: 5 * 365 * 24 * 60 * 60 * 1000
,
  multiple: 1000 # 1000 year
  base: 365 * 24 * 60 * 60 * 1000
  major: 100 * 365 * 24 * 60 * 60 * 1000
  minor: 10 * 365 * 24 * 60 * 60 * 1000
]

#
#  $scope.setTimelineUnits = (min, max) ->
#    major_units = []
#    minor_units = []
#    _min = new Date(min)
#    _max = new Date(max)
#    low_bound = $scope.getBoundedDate(_min, false)
#    high_bound = $scope.getBoundedDate(_max, true)
#    console.log(low_bound)
#
#  $scope.getBoundedDate = (d, is_max) ->
#    #buffer = 2000 * 365 * 24 * 60 * 60 * 1000
#    base = $scope.timeline.unit.base
#    shift = if is_max then base else 0
#    _date = new Date(d.getTime() + shift) #buffer
#    milli = undefined
#    sec = undefined
#    mns = undefined
#    hrs = undefined
#    day = undefined
#    mon = undefined
#    yr = undefined
#
#    if base <= 0 then milli = _date.getMilliseconds() else milli = 0
#    if base <= 1000 then sec = _date.getSeconds() else sec = 0
#    if base <= 60 * 1000 then mns = _date.getMinutes() else mns = 0
#    if base <= 60 * 60 * 1000 then hrs = _date.getHours() else hrs = 0
#    if base <= 24 * 60 * 60 * 1000 then day = _date.getDate() else day = 0
#    if base <= 31 * 24 * 60 * 60 * 1000 then mon = _date.getMonth() else mon = 0
#    if base <= 365 * 24 * 60 * 60 * 1000 then yr = _date.getFullYear() else yr = 0
#    new Date(yr, mon, day, hrs, mns, sec, milli)  #remove buffer?

#    diff = Math.abs(max_milli - min_milli)
#    a = 0
#    while a < 1000
#      unit = timelineUnits[a]
#      if diff < unit.base * unit.multiple
#        $scope.timeline.unit = timelineUnits[a]
#        break
#      a = a + 1
#    console.log(dates)
#    console.log($scope.timeline.unit)
#    $scope.timeline.min_date = $scope.getBoundedDate(min_milli, false)
#    $scope.timeline.max_date = $scope.getBoundedDate(max_milli, true)
#    $scope.timeline.major_units = $scope.setTimelineUnits(min_milli, max_milli)