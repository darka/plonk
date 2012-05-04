package  
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class WidgetContainer extends Widget
	{
		private var widgets:Array;
		public function WidgetContainer(game_:Game) 
		{
			super(game_);
			position = new Vec(0, 0);
			widgets = new Array();
		}
		
		public function addWidget(widget:SpriteWidget)
		{
			widgets.push(widget);
		}
		
		public override function updatePosition(newPosition:Vec)
		{
			var change:Vec = newPosition.sub(position);
			for (var i = 0; i < widgets.length; ++i)
			{
				widgets[i].updatePosition(widgets[i].position.add(change));
			}
			position = newPosition;
		}
		

		public override function unregister()
		{
			for (var i = 0; i < widgets.length; ++i)
			{
				widgets[i].unregister();
			}
		}
		
		public override function update()
		{
			for (var i = 0; i < widgets.length; ++i)
			{
				widgets[i].update();
			}
			super.update();
		}
	}
	
}