package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Game extends MovieClip
	{
		public var gameMode:GameMode;
		
		public var score:int;
	
		public const windowWidth = 640;
		public const windowHeight = 480;

		private var timers:Array;
		private var tick:int;
		
		private var paused:Boolean;
		
		public function Game() 
		{
			timers = new Array();
			tick = 0;
			score = 0;
			paused = false;
			
			gameMode = new Menu(this);
			gameMode.start();
			
			//startPlaying();
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function getPlayfield():Playfield
		{
			return LevelController(gameMode).playfield;
		}
		
		public function startPlaying()
		{
			gameMode = new LevelController(this);
			gameMode.start();
			
		}
		
		public function update(evt:Event)
		{
			gameMode.update();
			tick += 1;
			var changes:Array = new Array();
			// TODO: HANDLE IF CHECKING LAST OBJECT
			for (var i = 0; i < timers.length; ++i)
			{
				if (paused && !timers[i].global)
				{
					timers[i].nextTick += 1;
				}
				if (timers[i].has_finished())
				{
					
					timers[i] = timers[timers.length - 1];
					//if (i != timers.length - 1)
					//{
					timers.pop();
					i -= 1;
					//}
					continue;
				}
				else
				{
					timers[i].tick();
				}
			}
			//trace("timers: ", timers.length);
		}
		
		public function currentTick():int
		{
			return tick;
		}
		
		public function registerTimer(interval_:uint, repeatCount_:uint, func_:Function, global = false)
		{
			timers.push(new Timer(this, interval_, repeatCount_, func_, global));
		}
		
		public static function cleanOptimalArray(changes:Array, optimalArray:Array)
		{
			// <basro> I thought liero did the stack like array in which 
			// you add at the back and when removing an element you move 
			// the back towards that position1
			
			// might already be unused !
			
			// sort the array so there aren't any null places left
			var currentChange:uint = 0;
			var maxChanges:int = changes.length - 1;
			for (var j:int = optimalArray.length - 1; j >= 0; --j)
			{
				if (optimalArray[j] == null)
				{
					optimalArray.pop();
					maxChanges -= 1;
					continue;
				}
				if (currentChange <= maxChanges)
				{
					optimalArray[changes[currentChange]] = optimalArray[j];
					optimalArray.pop();
					currentChange++;
				}
				else
				{
					break;
				}
				
			}
		}
		
		public function pauseTimers()
		{
			paused = true;
		}
		
	}
	
}