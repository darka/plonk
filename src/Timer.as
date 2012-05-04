package  
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Timer extends OptimalArrayObject
	{
		public var interval:uint;
		private var timesActivated:uint;
		public var repeatCount:uint;
		public var nextTick:uint;
		private var finished:Boolean;
		private var func:Function;
		public var global:Boolean; // if true, timer runs even when game is paused
		
		public function Timer(game_:Game, interval_:uint, repeatCount_:uint, func_:Function, global_ = false ) 
		{
			super(game_);
			interval = interval_;
			repeatCount = repeatCount_;
			timesActivated = 0;
			func = func_;
			global_ = false;
			determineNextTick();
		}
		
		public function determineNextTick()
		{
			nextTick = game.currentTick() + interval;
		}
		
		public function tick()
		{
			if (!finished && nextTick == game.currentTick())
			{
				func();
				timesActivated += 1;
				if (timesActivated >= repeatCount)
				{
					finished = true;
				}
				else
				{
					determineNextTick();
				}
			}
		}
		
		public function has_finished():Boolean
		{
			return finished;
		}
	}
	
}