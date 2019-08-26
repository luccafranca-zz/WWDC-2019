/*:
  ![Swiftie the cat](Images/hi.png)
 
 ## Goals
 
This game aims at a playful and interactive introduction to American Sign Language.
 
 ## Considerations
 
Because it is an introductory interaction to the American sign language alphabet, all the words you will have to help Luigi understand will be spelled out. The speech used by the hearing impaired is based on the alphabet of sign language, but many sentences and words of this language have appropriate symbols to be represented.
 
There are many limitations to modeling approaches to real-time detection of complete sentences in the American sign language, with letter detection an approximation. The model was generated with a dataSet of 87,000 categorized, which was achieved 83% accuracy, which I consider acceptable for a concept validation.
 
 ## Usage Mode
 
The use of UIDevice.current.orientation does not return a significant value when used in Playgrounds. Because of this, the use of the game is restricted to the iPad in landscapeRight orientation (camera in the left side).
 
The game should be used in expanded mode to aid in reading and interacting with the camera.
 
 ## Credits
 
 ### Background music
 
"Pretty Things" available at [PurplePlanet](https://www.purple-planet.com/pretty-things) is licensed under [Usage Description](https://www.purple-planet.com/using-our-free-music)
 
 ### Correct hand sound
 
"Your Turn" available at [Notification Sounds](https://notificationsounds.com/message-tones/your-turn-491) is licensed under [CC Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/legalcode)
 
 
 ### Correct word sound
 
"Definite" available at [Notification Sounds](https://notificationsounds.com/notification-sounds/definite-555) is licensed under [CC Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/legalcode)
 
 ### Click sound
 
"Multimedia button click 4" available at [ZapSplat](https://www.zapsplat.com/music/multimedia-button-click-4/) is licensed under [Standard License](https://www.zapsplat.com/license-type/standard-license/)
 
 ### Fonts
 
"Open Sans" avaiable at [Google Fonts](https://fonts.google.com/specimen/Open+Sans) is licensed under [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0)
 
"Sniglet" avaiable at [Google Fonts](https://fonts.google.com/specimen/Sniglet) is licensed under [SIL OPEN FONT LICENSE](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL_web)
 
 
 ## Special Thanks
 
 To all my colleagues who helped me with the various bugs and problems that I experienced during this period. Thank you for accepting me sleepy :)
 
 > Good learning and I hope to practice with you at WWDC
 */

import PlaygroundSupport
import UIKit

let navigation = UINavigationController(rootViewController: PodcastViewController())
PlaygroundPage.current.liveView = navigation
