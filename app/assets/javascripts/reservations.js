
$(document).ready(function() { 
    $('#calendar').fullCalendar({        
       eventSources: [{
            url: '/reservations.json',
            color: '#513F3F',
            textColor: 'white'
        }]
    });
});



// eventAfterRender: function(event, element, view) {
//                       var height = $(".fc-week").height() - $(".fc-day-number").height()-10;
//                       $(element).css('height',height),
//                       $(element).css('opacity', '0.5')
//                     },