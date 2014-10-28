
$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        eventAfterRender: function(event, element, view) {
                      var height = $(".fc-week").height() - $(".fc-day-number").height()-10;
                      $(element).css('height',height),
                      $(element).css('opacity', '0.5')
                    },

       events: '/reservations.json'
    }); 

});
