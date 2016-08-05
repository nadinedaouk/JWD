import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Gesture;
import com.leapmotion.leap.processing.LeapMotion;

LeapMotion leapMotion;


int redColor = 0;
int currentModel = 0;
int totalModels = 2; // 
PShape [] models;
int [] redShade = {255,127};
int minTime = 0;
//PShape rocket;
boolean bDoSwipe = false;

float ry;
  
void setup() {
  size(640, 360, P3D);
  leapMotion = new LeapMotion(this);
  //rocket = loadShape("basic_ring.obj");
  
  models = new PShape[totalModels];
  
  // load each model
  models[0] = loadShape("basic_ring.obj");
  models[1] = loadShape("basic_ring.obj");//ring2.obj");
  
}

void draw() {
  background(redShade[currentModel],0,0);
  lights();
  translate(width/2, height/2 + 100, -200);
  rotateZ(PI);
  rotateY(ry);
   scale(10);
//shape(rocket);
  
  // draw current model
  shape( models[currentModel]);
  ry += 0.02;
  
  if(bDoSwipe){
    currentModel++;
    if(currentModel >= models.length) currentModel = 0;
    bDoSwipe = false;
  }
  
  if(minTime > 0 ){
    minTime--;
    println(minTime);
  }
}

void onInit(final Controller controller)
{

  controller.enableGesture(Gesture.Type.TYPE_SWIPE);
  // enable background policy
  controller.setPolicyFlags(Controller.PolicyFlag.POLICY_BACKGROUND_FRAMES);
}

void onFrame(final Controller controller)
{
  Frame frame = controller.frame();
  for (Gesture gesture : frame.gestures())
  {
   if ("TYPE_SWIPE".equals(gesture.type().toString()) && "STATE_START".equals(gesture.state().toString())) {
     
     //rocket = loadShape("ring2.obj");
    redColor = (int)random(255);
    if(minTime <= 0){ 
      bDoSwipe = true;
      minTime = 20;
    }
    }
    println("gesture " + gesture + " id " + gesture.id() + " type " + gesture.type() + " state " + gesture.state() + " duration " + gesture.duration() + " durationSeconds " + gesture.durationSeconds()); 
  }
}

void keyPressed(){
  currentModel++;
    if(currentModel >= models.length) currentModel = 0;
    println(currentModel);
}