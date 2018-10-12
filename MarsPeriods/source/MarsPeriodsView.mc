using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

class MarsPeriodsView extends WatchUi.View {
	// function nbWeeksInP13 returns number of weeks (integer) in P13
	// function takes a year (integer) as parameter
	// Beta from the MarsTime technical specs
	function nbWeeksInP13(marsyear) {
		var yearCurrentMoment = startDate(marsyear);  //get garmin moment for this year start date
		var yearNextMoment = startDate(marsyear + 1); //get garmin moment for next year start date
		var p12Current = yearCurrentMoment + 
	
	}
	
	
	// function startDate returns the first day of the Mars year
	// that contains the input year (integer) 
	function startDate(marsyear) {
		var options = {
    		:year   => marsyear,
    		:month  => 1,
    		:day    => 1
		};
		var date = Gregorian.moment(options);
		var iDay = Gregorian.info(date, Time.FORMAT_SHORT).day_of_week;
		//System.println(iDay);
		switch (iDay) {
			case 1:
				options = {:year => marsyear, :month => 1, :day => 1};
				break;
			case 2:
				options = {:year => marsyear - 1, :month => 12, :day => 31};
				break;
			case 3:
				options = {:year => marsyear - 1, :month => 12, :day => 30};
				break;
			case 4:
				options = {:year => marsyear - 1, :month => 12, :day => 29};
				break;
			case 5:
				options = {:year => marsyear - 1, :month => 12, :day => 28};
				break;
			case 6:
				options = {:year => marsyear, :month => 12, :day => 3};
				break;
			case 7:
				options = {:year => marsyear, :month => 12, :day => 2};
				break;
		} 
		return Gregorian.moment(options);
		
	}
	
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MarsWidget(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	var date = startDate(2018);
    	System.println(Gregorian.info(date, Time.FORMAT_SHORT).day_of_week);
    
    
    
    	/*
	
		// period
        var todayPeriod = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var datePeriodString = Lang.format("$1$$2$$3$",[todayPeriod.day,todayPeriod.month,todayPeriod.year]); 
		var viewPeriod = View.findDrawableById("MarsPeriodLabel");
        var array = WatchUi.loadResource(Rez.JsonData.jsonFile);
        viewPeriod.setText(array[datePeriodString]);
        
        // time
		var timeString = Lang.format("$1$:$2$",[todayPeriod.hour, todayPeriod.min.format("%02d")]);
        var viewTime = View.findDrawableById("TimeLabel");
        viewTime.setText(timeString);
        
        // date
        var todayDate = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var dateString = Lang.format("$1$ $2$ $3$",[todayDate.day,todayDate.month,todayDate.year]);
    	var viewDate = View.findDrawableById("DateLabel");
    	viewDate.setText(dateString);
  
    	*/
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
