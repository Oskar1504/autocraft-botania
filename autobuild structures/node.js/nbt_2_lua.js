const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});



rl.question('Which file do u want to convert: ', (answer) => {

  console.log('\nconverting:', answer);
  convert_file(answer);
  rl.close();
});
	


function getcolorcode(color){
	let output = 0;
	switch (color){
		case "white":
			output = 0;
			break;
		case "orange":
			output = 1;
			break;
		case "magenta":
			output = 2;
			break;
		case "light_blue":
			output = 3;
			break;
		case "yellow":
			output = 4;
			break;
		case "lime":
			output = 5;
			break;
		case "pink":
			output = 6;
			break;
		case "gray":
			output = 7;
			break;
		case "silver":
			output = 8;
			break;
		case "cyan":
			output = 9;
			break;
		case "purple":
			output = 10;
			break;
		case "blue":
			output = 11;
			break;
		case "brown":
			output = 12;
			break;
		case "green":
			output = 13;
			break;
		case "red":
			output = 14;
			break;
		case "black":
			output = 15;
			break;
	}
	return output
}



function convert_file(filename){
	var output_arr = [];

	var fs = require('fs'),
    nbt = require('nbt');
    
//count files
/*    const dir = './nbt_data';

fs.readdir(dir, (err, files) => {
  console.log(files.length);
});*/


	var data = fs.readFileSync('nbt_data/'+filename+'.nbt');
	nbt.parse(data, function(error, data) {
	    if (error) { throw error; }

	block = data.value.blocks.value.value;
	state = data.value.palette.value.value;
	size = data.value.size.value;
	
	
	console.log("\nLoad .nbt file");
	console.log("\nStructure size:"+size.value);
	output_arr.push({size:{x:size.value[0],y:size.value[1],z:size.value[2]}});

	for(var i = 0; i < block.length;i++){
		if(state[block[i].state.value].Name.value != "minecraft:air"){

			//stores data in array
			let x = block[i].pos.value.value[0],
				y = block[i].pos.value.value[1],
				z = block[i].pos.value.value[2],
				id = state[block[i].state.value].Name.value,
				damage = 0
		if(state[block[i].state.value].Properties){
			if(state[block[i].state.value].Properties.value.color){
				//console.log(state[block[i].state.value].Properties.value.color.value);
				damage = getcolorcode(state[block[i].state.value].Properties.value.color.value);
			}
		}
		else{
			console.log("Use 1.12 structures .nbt files to ensure converting functionality ");

		}
		/*console.log("Pos: "+x+" | " +y+" | " + z);
		console.log(id);*/

		output_arr.push({id:id,x:x,y:y,z:z,damage:damage})
	}
	}
	console.log("\nConverted color into cc readable values");
		
		cc_string = "";
		string = JSON.stringify(output_arr);
		for(var i =0; i < string.length;i++) {
				if(string[i] == "[" ){
					cc_string += "{";
					i++;
				}
				if(string[i] == "]" ){
					cc_string += "}";
					i++;
					break;
				}
				if(string[i] == '"' && string[i+1] != "," ){
					i++;
				}
				if(string[i] == ":" && string[i-1]!= "t"){
					cc_string += "=";
					
					i++;
				}
				cc_string += string[i];
			}
		console.log("\nScanned js object string and convert into cc readable table(lua).");

		fs.writeFile('cc_layer/'+filename+'.txt', cc_string, function (err) {
 		 if (err) throw err;
 		 console.log('\nConverted: '+filename+'.txt!');
	});
	});
}