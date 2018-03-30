//: ![The last page with the logo, I swear.](miles_logo.pdf)
/*:
 ## Ready for the improv?
 
 - Note:
 Jazz pieces created by Miles are different everytime, enjoy them all!
 
 #### Run the playground now to listen a new improvisation.
 
 ---
 
 While you listen...
 ## First, let's create our musicians.
 We can create pianos, basses and drums.
 
 Each instrument has its own `Improviser` that creates **MIDI** notes on the spot, like just a real musician does. Improvisers in charge of creating notes, chords, basslines and drum beats that work with each other.
 
 */
let drums = Drums(withParts: [.ride, .hihats, .snare, .bass], draws: false)
let bass = Bass(volume: 1, draws: true)
let piano = Piano(for: .comping, volume: 0.8, draws: true)
let pianoSoloer = Piano(for: .soloing, volume: 0.6, draws: true)
/*:
 ---
 ## Then, we decide which key the musicias will play in.
 
 To do this, we create a `Harmonization` instance. A harmonization sets the key and type of scales we'll use to improvise.
 
 * Experiment:
 Try changing:
 - The key of the harmony
 - The type of harmony
 
 Do your hear the difference in melodies and chords?
 */
let harmonization = Harmonization(key: .Eflat, type: .harmonicMinor)
/*:
 Now, we create a `Sequence` which allows our instruments to work togueter in order to create a song.
 
 * Experiment:
 Try different sequence combinations.
 - Change the tempo to make the music go faster o slower
 - Try removing instruments from the sequence to focus on others
 
 Cool, huh?
 */
let sequence = Sequence(harmonization: harmonization, tempo: 120, withInstruments: [drums, bass, piano, pianoSoloer])
/*:
 ---
 ## Now, we create a canvas
 
 So, you thought it could only create music? Wrong!
 Miles syncs cool abstract visuals to the music. It uses a `MilesCanvas` instance to display the generated art.
 
 Can you identify the instruments?
 * Experiment:
 Go back up and change the instrument's _draw_ property to make them draw or stop drawing to the canvas.

 */
import PlaygroundSupport
import SpriteKit

PlaygroundPage.current.needsIndefiniteExecution = true
let view = SKView(frame: CGRect(x: 0, y: 0, width: 800, height: 500))
PlaygroundPage.current.liveView = view

// Creates the canvas
let canvas = MilesCanvas()
canvas.scaleMode = .resizeFill
view.presentScene(canvas)

//Link the sequence and the new canvas
sequence.setDrawingCanvas(canvas)
/*:
 ---
 
 ## Enjoy!
 We tell our sequence to create an arrangement with the properties we specify and to play it for us to enjoy!
 
 * Experiment:
 Try running Miles several times. The music will be different everytime!
 */
sequence.createArrangement()
sequence.startPlaying()
/*: ### [Previous](@previous)


 ---
 ## Acknowledgements
 
 * The sound fonts used to sample the instruments were downloaded from [RKhive](http://fox-gieg.com/rkhive/index.html), under a Creative Commons License.
 * I learned a lot about MIDI and AudioToolbox from Gene de Lisa's [blog](http://www.rockhoppertech.com/blog/). Kudos to him!
 */
