package  
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Playfield extends GameObject
	{
		public var player:Player;
		
		public var playfieldObjects:Array;
		
		public var enemies:Array;
		public var bullets:Array;
		
		public const width = 640;
		public const height = 480;
		
		public const spawnCircleRadius = Math.sqrt((width / 2) * (width / 2) + (height / 2) * (height / 2)) + 50;
		
		public var destroyed:Boolean;
		public var ignorePlayer:Boolean;
		//public var visiblePlayer:Boolean;
		
		public const bubbleSpread = 20;
		public function Playfield(game_:Game) 
		{
			super(game_);
						
			player = new Player(game, new Vec(width / 2, height / 2));
			
			playfieldObjects = new Array();
			enemies = new Array();
			bullets = new Array();
			
			destroyed = false;
			ignorePlayer = true;
			player.makeInvisible();
			
			game.registerTimer(400, 1, function() 
			{
				player.fadeIn();
				ignorePlayer = false;
			});
			game.registerTimer(450, 1, function() { player.canShoot = true; } );
			//playfieldObjects.push(player);
			game.registerTimer(600, 1, function() { 
				game.registerTimer(450, 1000, spawnFlierSwarm);
				spawnFlierSwarm(); } );
			
		}
		
		public function update()
		{
			// TODO: do we even need "destroyed"?
			if (!ignorePlayer)
				player.update();
				
			var i:Number;
			
			for (i = 0; i < enemies.length; ++i)
				if (!ignorePlayer && enemies[i].collidesWith(player))
					enemies[i].handlePlayerCollision();
			
			for (i = 0; i < bullets.length; ++i)
				for (var j = 0; j < enemies.length; ++j)
					if (enemies[j].collidesWith(bullets[i]))
						enemies[j].handleBulletCollision(bullets[i]);
			
			for (i = 0; i < playfieldObjects.length; ++i)
			{
 				if (playfieldObjects[i].isOffscreen())
					playfieldObjects[i].markAsUnusedInArray();
				else
					playfieldObjects[i].update();

				if (playfieldObjects[i].isUnusedInArray())
				{
					
					if (playfieldObjects[i] is IdTrackedPlayfieldObject)
					{
						var array:Array;
						
						if (playfieldObjects[i] is Enemy)
							array = enemies;
						else if (playfieldObjects[i] is PlayerBullet)
							array = bullets;
						else
							throw new Error("Id-tracked object of unknown kind");
						
						var currentId:Number = playfieldObjects[i].id;
						
						array[currentId] = array[array.length - 1];
						array[currentId].id = currentId;
						array.pop();
					}
					
					playfieldObjects[i] = playfieldObjects[playfieldObjects.length - 1];
					playfieldObjects.pop();
					--i;
				}
			}
		}
		
		public function spawnFlierSwarm()
		{
			game.registerTimer(15 + 20 * Math.random(), 20, addFlier);
		}
		
		public function addBullet(position:Vec, direction:Vec)
		{
			var bullet:PlayerBullet = new PlayerBullet(game, bullets.length, position, direction);
			playfieldObjects.push(bullet);
			bullets.push(bullet);
		}
		
		public function addFlier()
		{
			//var enemy:Enemy = new Seeker(game, enemies.length, randomSpawnCircleLocation(), player);
			var enemy:Enemy = new Flier(game, enemies.length, randomSpawnCircleLocation(), player);
			playfieldObjects.push(enemy);
			enemies.push(enemy);
		}
		
		public function addBubbles(position:Vec, count:Number, randomLocations:Boolean)
		{
			var spawnPosition:Vec = position;
			/*for (var i = 0; i < count; ++i)
			{
				
				if (randomLocations)
				{
					spawnPosition = spawnPosition.add(new Vec(bubbleSpread * Math.random(), bubbleSpread * Math.random()));
				}
				else
				{
					spawnPosition = spawnPosition.add(new Vec(bubbleSpread, bubbleSpread));
				}
				
			}*/
			playfieldObjects.push(new Bubble(game, 
			                                 spawnPosition.sub(new Vec(bubbleSpread / 2, 
			                                                           bubbleSpread / 2)).add(new Vec(Math.random() * bubbleSpread,
																	                              Math.random() * bubbleSpread))));
		}
		
		public function addExplosion(position:Vec)
		{
			playfieldObjects.push(new Explosion(game, position));
			//addBubbles(position, 10, true);
		}
		
		public function addMuzzleFlash(rotation:Number)
		{
			playfieldObjects.push(new MuzzleFlash(game, player, rotation));
		}
		
		public function randomSpawnCircleLocation():Vec
		{
			var angle:Number = Math.random() * 2 * Math.PI;
			return new Vec(width / 2 + spawnCircleRadius * Math.cos(angle), 
			               height / 2 + spawnCircleRadius * Math.sin(angle));
		}
		
		public function destroy()
		{
			// TODO: DEACTIVATE player controls
		
			player.unregisterSprite();
			player.canShoot = false;
			addExplosion(player.position);
			ignorePlayer = true;
			
			game.registerTimer( 50, 1, function() 
			{ 
				var i;
				for (i = 0; i < enemies.length; ++i)
				{
					enemies[i].die(); 
				}
				game.registerTimer(10, 1, function()
				{
					for (i = 0; i < playfieldObjects.length; ++i)
					{
						playfieldObjects[i].markAsUnusedInArray();
					}
				});
			}, true );
			
			
			destroyed = true;
			game.pauseTimers();
		}
	}
	
}