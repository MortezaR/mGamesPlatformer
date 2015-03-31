package bbone {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filesystem.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.net.dns.ARecord;
	import allObj.perObj.aSwitch;
	import allObj.enemy;
	import flash.geom.Point;
	import allObj.conObj.wall;
	import allObj.perObj.NPC;
	import allObj.Obj;

	public class objFr extends MovieClip{
		var listObj:Array = new Array;
		var listDia:Array = [];
		var mapHeight:int;
		var mapWidth:int;
		var mapLoaded:Boolean;
		var aSwi:aSwitch;
		var emy:enemy;
		var aWall:wall;
		var aNPC:NPC;
		
		public function objFr() {
			mapLoaded = false;
		}
		public function addObj(a:MovieClip) {
			
			listObj.push(a);
			this.addChild(a);
		}
		public function LOAD (curMap:int, curStage:int){
			var file:File = File.desktopDirectory;
			var input:String = new String;
			file = file.resolvePath("TravlerRPG/stages/MAP" + curStage + "_" + curMap +".txt");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			input = fileStream.readUTFBytes(fileStream.bytesAvailable);
			var a:Array = input.split(">>");
			fileStream.close();
			mapWidth = int(a[0]);
			mapHeight = int(a[1]);
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loadimage);
			ldr.load(new URLRequest("stages/image" + curStage + "_" + curMap +".png"));
			function loadimage(evt:Event):void {
				var bmp:Bitmap = ldr.content as Bitmap;
				addChildAt(bmp, 0);
				bmp.height = mapHeight;
				bmp.width = mapWidth;
			}
			var b:Array = a[2].split("\n");
			for (var i:String in b){
				var c:Array = b[i].split(" ");
				if(c[0] == "aSwitch"){
					aSwi = new aSwitch();
					aSwi.name = c[3];
					this.addObj(aSwi);
					aSwi.x = c[1];
					aSwi.y = c[2];
					if(c[4] == "true"){
						aSwi.turnON();
					}
				}
				if(c[0] == "enemy"){
					var p:Array = [];
					p.push(new Point(c[1],c[2]));
					p.push(new Point(c[6],c[7]));
					p.push(new Point(c[8],c[9]));
					emy = new enemy(c[4],c[5],p);
					emy.name = c[3];
					this.addObj(emy);
					emy.x = c[1];
					emy.y = c[2];
				}
				if(c[0] == "wall"){
					aWall = new wall(c[4],c[5]);
					aWall.name = c[3];
					this.addObj(aWall);
					aWall.x = c[1];
					aWall.y = c[2];
				}
				if(c[0] == "NPC"){
					aNPC = new NPC(c[4]);
					aNPC.name = c[3];
					this.addObj(aNPC);
					aNPC.x = c[1];
					aNPC.y = c[2];
				}
			}
			var d:Array = a[3].split("\n");
			for (var i:String in d){
				listDia[i] = d[i];
			}
			/*var e:Array = a[4].split("\n");
			for(var i:String in e)
				*/
		}
		public function save() {
			var file:File = File.desktopDirectory;
			file = file.resolvePath("TravlerRPG/thegoods.txt");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			trace(fileStream.writeInt(1111));
			fileStream.close();
		}
		public function objList():Array{
			return listObj;
		}
		
		
	}
	
}