Arduinome {
	
	var <>port;
	var osc, prefix;
	
	*new { arg prefix;
		^super.new.init(prefix);
	}
	
	init { arg prefix_, port_=8080;
		prefix = prefix_;
		port = port_;
		
		osc = NetAddr("localhost", port);
		osc.sendMsg("/sys/prefix", prefix);			
	}
	
	// osc commands
	clear {
		osc.sendMsg(prefix++"/clear", 0);
	}
	
	ledonoff { arg xy, onoff;
		osc.sendMsg(prefix++"/led", xy[0], xy[1], onoff); 
	}
}