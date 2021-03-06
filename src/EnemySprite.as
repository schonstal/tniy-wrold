package 
{
  import org.flixel.*;

  public class EnemySprite extends FlxSprite 
  {
    public var wordGroup:WordGroup;
    public var shadow:EnemyShadow;
    public var lane:EnemyLane;

    private var walking:Boolean = true;
    private var flailing:Boolean = false;
    private var readyToFling:Boolean = false;
    private var preparingToExplode:Boolean = false;

    protected var shakeAmount:Number;
    protected var walkSpeed:Number;
    protected var minSize:Number;
    protected var maxSize:Number;
    protected var lowVelocity:Number;
    protected var explosionFrames:Array;
    protected var baseAngular:Number;
    protected var damage:Number;
    public var letterOffset:Number = 0; //LOL
    protected var startX:Number;

    public static const VARIANCE:Number = 5;
    public static const EXPLOSION_TIME:Number = 0.5;

    public function EnemySprite() {
      super(FlxG.width, FlxG.height/2);
    }

    public function create():void {
      wordGroup = new WordGroup();
      G.wordGroupGroup.add(wordGroup);

      addAnimation("walk", [0,1,2,3,4,5,6,7,8,9], 20, true);
      addAnimation("flail", [0,9], 30);
      addAnimation("prepare_to_explode", explosionFrames, 15, false);

      play("walk");
      _curAnim.delay = 1/walkSpeed;
    }

    public function init(Y:Number):void {
      y = Y + Math.random() * VARIANCE;
      x = startX + Math.random() * VARIANCE;
      var word:Array = G.randomWord(minSize, maxSize);
      wordGroup.init(word, x+(width/2), y-LetterSprite.WIDTH + letterOffset, this);
      G.takeLetter(word[0], wordGroup);
      exists = true;
      preparingToExplode = false;
      readyToFling = false;
      flailing = false;
      walking = true;

      play("walk");

      wordGroup.xVelocity = velocity.x = -walkSpeed;
    }

    public function fling():void {
      readyToFling = true;
      if(this is LargeEnemySprite) {
        FlxG.play(Assets.BigFly, 0.4);
      } else {
        FlxG.play(Assets.LilFly, 0.25);
      }
    }

    public function stop():void {
      walking = false;
    }

    public override function update():void {
      if(!walking || x > PlayState.DEATH_ZONE - width/2) {
        if(!flailing) {
          if(readyToFling) {
            flailing = true;
            angularVelocity = LetterSprite.EXPLOSION_ANGULAR * Math.random();
            velocity.y = lowVelocity + (Math.random() * -20);
            velocity.x = LetterSprite.EXPLOSION_X + (Math.random() * LetterSprite.EXPLOSION_X_MIN/2);
            play("flail");
            if(x > FlxG.width) exists = false;
          }
        }
      } else {
        if(!preparingToExplode) {
          velocity.x = 0;
          play("prepare_to_explode");
          preparingToExplode = true;
          wordGroup.prepareToDie();
          if(this is LargeEnemySprite) {
            FlxG.play(Assets.BigCharge);
          } else {
            FlxG.play(Assets.LilCharge, 0.4);
          }
        }
        if(finished) {
          FlxG.shake(0.01, shakeAmount);
          lane.onExplode(x,y);
          exists = false;
          shadow.exists = false;
          wordGroup.complete();
          G.health -= damage;
          if(G.face) G.face.wince();
          if(this is LargeEnemySprite) {
            FlxG.play(Assets.BigBoom);
          } else {
            FlxG.play(Assets.LilBoom);
          }
        }
      }

      super.update();
    }
  }
}
