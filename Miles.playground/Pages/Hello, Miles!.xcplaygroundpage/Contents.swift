//: ![I could not resist designing a logo](miles_logo.pdf)
/*:
 ##### The jazz improviser playground.
 In my opinion, one of the most amazing things of jazz is that it relies on improvisation. Musicians play whatever they can come up with in the moment, and maybe they are never able to play that again. It's amazing.
 
 Being such an fan, I decided to create **Miles:** A playground that can improvise and play jazz pieces.
 
 Jazz is very complex artform, so I created a `PianoTeacher` class that understands a lot music theory and will clear up some concepts before we begin. Are you ready?
 
 ---
 */
//First, we'll create a view to display our music.
import PlaygroundSupport
import SpriteKit

PlaygroundPage.current.needsIndefiniteExecution = true
let view = SKView(frame: CGRect(x: 0, y: 0, width: 800, height: 500))
PlaygroundPage.current.liveView = view
// Creates the canvas
let canvas = MilesCanvas()
canvas.colorPalette = NSColor.ramboSunshine
canvas.scaleMode = .resizeFill
view.presentScene(canvas)
/*:
 ---
 
 ## The basics: Scales
 
 A **scale** is set of musical notes that are based on a fundamental pitch or tone. Jazz and music in general rely on scales to create songs and melodies with notes that sound good with each other.
 
  ▶️**Run** the playground to make the teacher play a scale.
 
 * Experiment:
 Modify the arguments in the `play` method to listen to other types of scales.
 
 Can you see how some scales feel different than others? 
 */
let pianoTeacher = PianoTeacher()
pianoTeacher.canvas = canvas
pianoTeacher.play(scale: .blues, inKey: .Eflat, inOctaves: [2,3,4], withTempo: 150, useStaticTime: true)
/*:
 ---
 
 Awesome! But jazz relies on another very important basic element: **Rythm**. In the scale you just heard, all notes had the same duration, lets change that and see how rythm can affect a melody.
 
 * Experiment:
 Go back to our music teacher's `play` method and change the argument `useStaticTime` to `false`. Now the notes in the scale have a different time value.
 
Cool right?
 
 ---
 
 ## [Next](@next)
 
 */
