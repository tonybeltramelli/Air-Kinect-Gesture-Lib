#Air-Kinect-Gesture-Lib
======================

Air Kinect Gesture Lib is a code library for use with Adobe AIR 3.0 and the Microsoft Kinect Native Extension written by the as3NUI team.( <https://github.com/AS3NUI/airkinect-2-core/> )
You will find all the sources and a swc file in the bin folder.

* Video demo here : <http://www.youtube.com/watch?v=1L7EPo8bsAg&feature=plcp/>
* AIR application control demo video and gestures recognition : <http://youtu.be/izOJjuomgGg/>

##Requirements

Actionscript IDE supporting AIR 3.0 projects. (Flash Builder 4.6, IntelliJ, FDT, ...)
A working Kinect and the airkinect-2-core.ane file in your project (install informations here : <http://as3nui.github.com/airkinect-2-core/>)

##Gestures and movements available

Gestures :

 * GestureDirection.SWIPE_HORIZONTAL;
 * GestureDirection.SWIPE_RIGHT;
 * GestureDirection.SWIPE_LEFT;
 * GestureDirection.SWIPE_VERTICAL;
 * GestureDirection.SWIPE_UP;
 * GestureDirection.SWIPE_DOWN;
 * GestureDirection.SWIPE_DEPTH;
 * GestureDirection.SWIPE_FORWARD;
 * GestureDirection.SWIPE_BACKWARD;

Movements :

 * JumpMovement;
 * BendDownMovement;

##Syntax and code snippets

You will find an example class in this repository.
You can use the ActionScript3 native event system or the as3 Signal develop by Robert Penner. ( <https://github.com/robertpenner/as3-signals/> )

<pre><code>//instantiation of an ActionManager with the stage frame rate in parameter in order to compute the gestures analysis
_actionManager = new ActionManager(stage.frameRate);

//creation of a gesture to track the left swipe with the left hand
//the detection will dispatch a KinectGestureEvent.LEFT_SWIPE in this case
var rightHandLeftSwipe : LeftSwipe = new LeftSwipe(GesturePart.RIGHT_HAND);
rightHandLeftSwipe.dispatcher.addEventListener(KinectGestureEvent.LEFT_SWIPE, _leftSwipeWithRightHandOccured);
//then, if you need to remove your event Listener, you can do it this way
//rightHandLeftSwipe.dispatcher.removeEventListener(KinectGestureEvent.LEFT_SWIPE, _leftSwipeWithRightHandOccured);

//in order to works, don't forget to add your gestures and / or movements to your ActionManager instance
_actionManager.add(rightHandLeftSwipe);
</code></pre>

Then in your enterFrame handler, add this line.

<pre><code>//ask your ActionManager to compute and analyze user's actions
_actionManager.compute(user);
</code></pre>

Here some code to show you how to use Signal instead of ActionScript3 Event.

<pre><code>//by default, the dispatcher of all AUserAction will be an EventDispatcher but you can also use
//the AS3 Signals by passing an instance of ActionSignalDispatcher to the AUserAction instance
var jumpMovement : JumpMovement = new JumpMovement(new ActionSignalDispatcher());
jumpMovement.dispatcher.addSignalListener(_jumpMovementOccured);
//for a signal dispatcher, you can remove your listener this way
//jumpMovement.dispatcher.removeSignalListener(_jumpMovementOccured);
</code></pre>

Multiple gesture manager.

<pre><code>//rather than create two gestures (UpSwipe and DownSwipe for example) you can use
//a VerticalSwipe to handle two gestures in only one instance
var leftHandVerticalSwipe : VerticalSwipe = new VerticalSwipe(GesturePart.LEFT_HAND);
leftHandVerticalSwipe.dispatcher.addEventListener(KinectGestureEvent.UP_SWIPE, _upSwipeWithLeftHandOccured);
leftHandVerticalSwipe.dispatcher.addEventListener(KinectGestureEvent.DOWN_SWIPE, _downSwipeWithLeftHandOccured);
//remove event listener like shown below
//leftHandVerticalSwipe.dispatcher.removeEventListener(KinectGestureEvent.UP_SWIPE, _upSwipeWithLeftHandOccured);
//leftHandVerticalSwipe.dispatcher.removeEventListener(KinectGestureEvent.DOWN_SWIPE, _downSwipeWithLeftHandOccured);
        	
//if you want to use Signal dispatcher with a two gestures handler (HorizontalSwipe, VerticalSwipe or DepthSwipe)
//you can listen to your signal callback with the method below
var leftFootHorizontalSwipe : HorizontalSwipe = new HorizontalSwipe(GesturePart.LEFT_FOOT, new ActionSignalDispatcher());
leftFootHorizontalSwipe.dispatcher.addSignalListener(_horizontalLeftFootSwipeDirectionOne);
ActionSignalDispatcher(leftFootHorizontalSwipe.dispatcher).addSecondSignalListener(_horizontalLeftFootSwipeDirectionTwo);
//with the same logic, you can easily remove your signal listener
//leftFootHorizontalSwipe.dispatcher.removeSignalListener(_horizontalLeftFootSwipeDirectionOne);
//ActionSignalDispatcher(leftFootHorizontalSwipe.dispatcher).removeSecondSignalListener(_horizontalLeftFootSwipeDirectionTwo);
</code></pre>

##Contact

I am still looking for impressions, critiques and suggestions so don't hesitate to contact me.
My email is contact _at_ tonybeltramelli.com.
Follow me on Twitter @Tbeltramelli : <http://twitter.com/#!/tbeltramelli/>.

Have fun with this lib !