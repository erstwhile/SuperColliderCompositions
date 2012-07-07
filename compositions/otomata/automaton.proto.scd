
Automaton {
	
	var <xy; // 2-d list indicating (x,y) grid position
	var <d; // 2-d list indicating direction of movement
	var hit=false;
	var note=0, on=false;
	
	var midi;
	var arduinome;
	var scale, offset;
	var width, height, gridsize;
	
	*new { arg xy, arduinome, midi, width=8, height=8;
		^super.new.init(xy, arduinome, midi, width, height);
	}
	
	// initialize
	init { arg xy_, arduinome_, midi_, width_, height_;
		
		// initial grid point
		xy = xy_;			
		d = [0,1];
		
		width = width_;
		height = height_;
		gridsize = width*height;
		
		// check boundary conditions
		// (in case point was initialized on a boundary)
		if ( 	((d[0]==1) && (xy[0]==(height-1))) ||
			((d[0]==(-1)) && (xy[0]==0)) ||
			((d[1]==1) && (xy[1]==(width-1))) ||
		     	((d[1]==(-1)) && (xy[1]==0)), 
		     	{d = d*(-1);},{});
		     	
		// setup osc
		arduinome = arduinome_;
		arduinome.ledonoff(xy,1); // turn on led
		
		// setup midi
		midi = midi_;	
		
		// scale
	   	offset = 48;
	   	scale = [ 4, // E
   				11, // B
   				12, // C
   				14, // D
	   			16, // E
   				18, // F#
   				19, // G
   				21  // A
	   			];						
	}
	
	// do every clock cycle
	tick {
		
		//arduinome.ledonoff(xy[0], xy[1], 0); // turn off led							
		xy = xy + d; // increment grid position
		arduinome.ledonoff(xy,1); // turn on led
		     		
		// check boundary conditions
		hit = false;
		if ( ((d[0]==1) && (xy[0]==(height-1))), {hit=true; note=xy[1];}, {} );
		if (	((d[0]==(-1)) && (xy[0]==0)), {hit=true; note=xy[1];}, {} );
		if (	((d[1]==1) && (xy[1]==(width-1))), {hit=true; note=xy[0];}, {} );
		if ( ((d[1]==(-1)) && (xy[1]==0)), {hit=true; note=xy[0];}, {} );
		     		 						
		if( hit, 		
			{
				d = d*(-1); // change direction
				// midi on
				"hit".postln;
				note.postln;
				midi.noteOn(0, scale.wrapAt(note) + offset, 100);
				on = true;
				//"note on".postln;
								
			}, 	
			{ 
				// midi off
				if( on, {
					midi.noteOff(0, scale.wrapAt(note) + offset, 0);
					on = false;
					//"note off".postln;
				},{});
			});
		
		^(xy[1]*height + xy[0]) // return grid position
	}
	
	// change direction
	collision {		
		var tmp;
		tmp = d[0];
		d[0] = d[1];
		d[1] = tmp;		
		
		// check boundary conditions
		// (in case collision occured on a boundary)
		if ( 	((d[0]==1) && (xy[0]==(height-1))) ||
			((d[0]==(-1)) && (xy[0]==0)) ||
			((d[1]==1) && (xy[1]==(width-1))) ||
		     	((d[1]==(-1)) && (xy[1]==0)), 
		     	{d = d*(-1);},{});
		     	
		// error checking
		if ( ((d[0]!=0) && (d[1]!=0)), {"off the charts!".postln;}, {} );
	}
	
}