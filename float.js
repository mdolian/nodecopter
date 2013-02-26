var arDrone = require('ar-drone');

var drone_ip = process.argv[2]
var our_copter = process.argv[3]
var client  = arDrone.createClient({ip: drone_ip});

client.resume();
client.takeoff();

client
    .after(5000, function() {
        this.up(0.3)
    })
    .after(6500, function() {
        this.stop()
    });

client
    .after(1000, function() {
        this.clockwise(0.7)
    })
    .after(5000, function() {
        this.stop()
    });

client
		.after(1000, function() {
		 	this.animate('wave', 2000)
		});

if(our_copter == "yes")	{
	client
			.after(4000, function() {
			 	this.animate('flipAhead', 15)
			});

	client
	    .after(5000, function() {
	        this.up(0.3)
	    })
	    .after(5000, function() {
	        this.stop()
	    });

	client
			.after(1000, function() {
			 	this.animate('flipLeft', 15)
			});
}

client				
		.after(5000, function() {
        this.stop();
        this.land();
     });

setTimeout(function() {
    process.exit()
}, 50000)

