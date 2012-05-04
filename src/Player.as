package  
{
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Player extends PlayfieldObject
	{
		private var movementAngle:Number;
		//private var shootingAngle:Number;
		
		private var movingUp:Boolean;
		private var movingDown:Boolean;
		private var movingLeft:Boolean;
		private var movingRight:Boolean;
		
		private var accelerating:Boolean;
		//private var decelerating:Boolean;
		
		private var shooting:Boolean;
		
		
		private var direction:Vec;
		
		private var velocity:Vec;
		private var acceleration:Vec;
		
		private const rotationSpeed = 11.25;
		private const accelerationCoef = 0.4;
		//private const decelerationCoef = 0.3;
		private const maxSpeedForward = 2;
		//private const maxSpeedBackward = 4;
		private const friction = 0.9;
		private const edgeHitCoef = 0.4;
		private const shootingDelay = 15;
		private const collisionRadius = 10;
		
		private var playerGun:PlayerGun;
		private const playerGunPosition:Vec = new Vec(0, 0);
		
		public var canShoot:Boolean;
		public var health:Number;
		public var dead:Boolean;
		
		public var phaserSound:Sound;
		
		public function Player(game_:Game, position_:Vec) 
		{
			super(game_, new PlayerSprite(), position_);
			movementAngle = 90;
			
			direction = new Vec(0.0, -1.0);
			velocity = new Vec(0.0, 0.0);
			acceleration = direction.mult(accelerationCoef);
			
			playerGun = new PlayerGun(game);
			health = 100;
			
			makeColidable(collisionRadius);
			
			shooting = false;
			canShoot = false;
			phaserSound = new PhaserSound();
			dead = false;
		}
		
		public function makeInvisible()
		{
			sprite.alpha = 0;
		}
		
		public function startMovingLeft() { movingLeft = true; movingRight = false; }
		public function stopMovingLeft() { movingLeft = false; }
		
		public function startMovingRight() { movingRight = true; movingLeft = false; }
		public function stopMovingRight() {	movingRight = false; }
		
		public function startMovingUp()	{ movingUp = true; movingDown = false;}
		public function stopMovingUp() { movingUp = false; }
		
		public function startMovingDown() { movingDown = true; movingUp = false; }
		public function stopMovingDown() { movingDown = false; }
		
		/*
		public function startAccelerating()
		{
			accelerating = true;
		}
		
		public function stopAccelerating()
		{
			accelerating = false;
		}
		
		
		public function startDecelerating()
		{
			decelerating = true;
			accelerating = false;
		}
		
		public function stopDecelerating()
		{
			decelerating = false;
		}
		*/
		
		public function startShooting()
		{
			shooting = true;
		}
		
		public function stopShooting()
		{
			shooting = false;
		}
		
		public function shoot()
		{
			var playfield:Playfield = game.getPlayfield();
			playfield.addBullet(position, new Vec(Math.cos(playerGun.angle), Math.sin(playerGun.angle)));
			playfield.addMuzzleFlash(playerGun.sprite.rotation);
			phaserSound.play();
		}
		
		public function shootSpreadGun()
		{
			const spread = Math.PI / 6;
			var playfield:Playfield = game.getPlayfield();
			playfield.addBullet(position, new Vec(Math.cos(playerGun.angle), Math.sin(playerGun.angle)));
			playfield.addBullet(position, new Vec(Math.cos(playerGun.angle + spread), Math.sin(playerGun.angle + spread)));
			playfield.addBullet(position, new Vec(Math.cos(playerGun.angle - spread), Math.sin(playerGun.angle - spread)));
			playfield.addMuzzleFlash(playerGun.sprite.rotation);
		}
		
		public override function update()
		{
			if (movingLeft || movingRight || movingUp || movingDown)
			{
				var targetAngle:Number = movementAngle;
				if (movingLeft) 
				{
					targetAngle = 360;
					if (movingUp) targetAngle = 45;
					else if (movingDown) targetAngle = 315;
				}
				else if (movingRight)
				{
					targetAngle = 180;
					if (movingUp) targetAngle = 135; 
					else if (movingDown) targetAngle = 225;
				}
				else if (movingUp)
				{
					targetAngle = 90;
				}
				else if (movingDown)
				{
					targetAngle = 270;
				}
				
				if (targetAngle != movementAngle)
				{
					if ((targetAngle > movementAngle && (targetAngle - movementAngle < 180)) ||
					     (targetAngle < movementAngle) && (360 - movementAngle + targetAngle < 180))
					{
						movementAngle += rotationSpeed;
					}
					else
					{
						movementAngle -= rotationSpeed;
					}
				}
				
				if (movementAngle < 0)
					movementAngle = movementAngle + 360;
					
				if (movementAngle > 360)
					movementAngle = movementAngle - 360;
				
				//trace(movementAngle);
				sprite.rotation = movementAngle - 90;
				var angleInRadians = movementAngle * Math.PI / 180.0;
				direction = new Vec( -Math.cos(angleInRadians), -Math.sin(angleInRadians));
				
				// TODO: we don't need all this
				accelerating = true;
			}
			else
			{
				accelerating = false;
			}
			
			if (accelerating && velocity.length() < maxSpeedForward)
			{
				acceleration = direction.mult(accelerationCoef);
				velocity = velocity.add(acceleration);
			}
			/*else if (decelerating && velocity.length() < maxSpeedBackward)
			{
				acceleration = direction.mult( -decelerationCoef);
				velocity = velocity.add(acceleration);
			}*/
			else
			{
				velocity = velocity.mult(friction);
			}

			var newPosition = position.add(velocity);
			if (newPosition.x < 0 || 
			    newPosition.x > LevelController(game.gameMode).playfield.width)
			{
				velocity = velocity.mult(edgeHitCoef);
				velocity.x = -velocity.x;
				newPosition = position.add(velocity);
			}
			else if (newPosition.y < 0 || 
			         newPosition.y > LevelController(game.gameMode).playfield.height)
			{
				velocity = velocity.mult(edgeHitCoef);
				velocity.y = -velocity.y;
				newPosition = position.add(velocity);
			}
			
			if (shooting)
			{
				if (canShoot)
				{
					shoot();
					//shootSpreadGun();
					canShoot = false;
					game.registerTimer(shootingDelay, 1, function() { canShoot = true; } );
				}				
			}
			position = newPosition;
			super.update();
			playerGun.position = position;
			playerGun.update();
			spawnBubblesAroundMaybe();
			if (health <= 0)
				dead = true;
		}
		
		public override function fadeIn()
		{
			playerGun.fadeIn();
			super.fadeIn();
		}
		
		public function adjustGun(mousePosition:Vec)
		{
			playerGun.trackMouse(mousePosition);
		}
		
		public override function unregisterSprite()
		{
			super.unregisterSprite();
			playerGun.unregisterSprite();
		}
		
	}
	
}