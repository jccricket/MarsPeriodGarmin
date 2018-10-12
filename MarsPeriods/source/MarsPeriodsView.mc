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
	// refer to https://developer.garmin.com/connect-iq/api-docs/ regarding moment and duration in Garmin SDK
	function nbWeeksInP13(marsyear) {
		var yearCurrentMoment = startDateOfMarsYear(marsyear);  //get garmin moment for this year start date
		var yearNextMoment = startDateOfMarsYear(marsyear + 1); //get garmin moment for next year start date
		var days12x28 = new Time.Duration(29030400); // 12 periods of 28 days times number of second in one day
		var p12Current = yearCurrentMoment.add(days12x28); //moment in this year that correspond to end of P12
		var momentDiff = yearNextMoment.subtract(p12Current); //get duration between the 2 moments (start of next year P1 minus end of P12 current year)
		var nbDays = momentDiff.value()/86400; //86400 is number of seconds in one day.

		var nbWP13 = 1; //error code 1
		switch (nbDays.toNumber()) {
			case 28:
				nbWP13 = 4;
				break;
			case 35:
				nbWP13 = 5;
				break;
		}
		return nbWP13;
	}
	
	
	// function startDate returns the first day of the Mars year in a Garmin moment format
	// that contains the input year (integer) 
	function startDateOfMarsYear(marsyear) {
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
	
	// function cMarsDate convert a garmin moment into a Mars Calendar Periodic format: PxxWyyDz
	function cMarsDate(garminMomentNow) {
		var date = Gregorian.info(garminMomentNow, Time.FORMAT_SHORT);
		var marsYear = date.year;
		var yearStart = startDateOfMarsYear(marsYear);
		
		// if now is earlier than start of the Mars year, we are in previous Mars year...
		if ( garminMomentNow.lessThan(yearStart) ) {
			marsYear = marsYear.toNumber() - 1;
			yearStart = startDateOfMarsYear(marsYear);
		}
		
		var nbDays = garminMomentNow.subtract(yearStart).value()/86400; // 86400 is the number of seconds in one day
	
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
    	var date = startDateOfMarsYear(2018);
    	//System.println(Gregorian.info(date, Time.FORMAT_SHORT).day_of_week);
    	
    	System.println(nbWeeksInP13(2018));
    
    
    
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
