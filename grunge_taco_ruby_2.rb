class Scene
  def enter()
    puts "This scene is not yet configured. Subclass it and implement enter()."
    exit(1)
  end
end


class Death < Scene

    def enter()
        print "\nYou dead. Game over. Good job!\n\n"
        exit(1)
    end
end

class Finished < Scene

  def enter()
    puts "You won! Good job!"
  end
end


class Kitchen < Scene

  @@inventory = []
  @@tried_safe = false

  def enter()
    intro_text = dynamic_intro
    puts intro_text
      
    print "> "
    choice = $stdin.gets.chomp

    if choice.include?("north") || choice.include?("lobby")
      puts "You exit the kitchen and head back into the lobby. You start"
      puts "walking towards the soda machine. A nice orange soda would taste"
      puts "really good right about now. You notice that Ray-Ray and Deshaun"
      puts "are no where to be seen. They must have untied themselves while"
      puts "you were in the kitchen. You decide not to worry about it. You"
      puts "just want to drink a nice refreshing soda, chill out, and earn"
      puts "your hourly wage while you wait for the cops arrive."
      puts ""
      puts "You grab an extra large cup, you add some ice, and then you start"
      puts "filling it up with that delicious orange drink you've been"
      puts "craving. You then start walking towards one of the tables to sit"
      puts "down and enjoy your beverage when all of a sudden the front doors"
      puts "to Grunge Taco swing open. You see Ray-Ray and Deshaun and about a"
      puts "dozen police officers dressed in full S.W.A.T. team gear."
      puts ""
      puts "\"That's the guy who did this\" says Ray-Ray pointing at you."
      puts ""
      puts "You try to protest but one of the police officers yells at you to"
      puts "keep quite and to put your hands in the air. You immediately raise"
      puts "your hands. You raise them so fast that is causes the orange soda"
      puts "to go flying out of the cup and into the air." 
      puts ""
      puts "\"He's got a gun!\" yells Deshaun."
      puts ""
      puts "You don't have a gun, or anything that even remotely looks like a"
      puts "gun. In the heat of the moment the flying ice cubes and orange"
      puts "soda coupled with Deshaun's outcry must have been enough to set"
      puts "off the itchy trigger fingers of the S.W.A.T. Team. You are shot"
      puts "about fifty times and you and your orange soda both die instantly."
      return "death"
    elsif choice.include?("south") || choice.include?("back door")
      if @@inventory.include?("money")
        puts "You open the back door and head into the alley. You secure the"
        puts "trash bag full of cash to the rear rack of your mountain bike"
        puts "with some bungee cords. Today must be your lucky day you think"
        puts "to yourself. You avoided getting slaughtered and you are now the"
        puts "proud owner of a giant bag full of cash."
        puts ""
        puts "You jump on your bike, wave goodbye to Grunge Taco, and ride"
        puts "home through the trail in the woods to your apartment. You and"
        puts "your bag of money live happily ever after. THE END."
        return "finished"
      else
        puts "You open the back door and head into the alley. Today must be"
        puts "your lucky day you think to yourself. You avoided getting"
        puts "slaughtered and you even had a nice nap."
        puts ""
        puts "You jump on your bike, wave goodbye to Grunge Taco, and begin"
        puts "riding home through the trail in the woods to your apartment."
        puts "You travel about 100 feet when you see something large blocking"
        puts "the path so you slam on your brakes. That something turns out to"
        puts "be a giant grizzly bear. The bear stands up on its hind legs and"
        puts "begins growling and waving its giant paws around. You try to"
        puts "turn around and ride back Grunge Taco but the bear is too fast"
        puts "for you and easily plucks you off of your bike and slams your"
        puts "body repeatly on the ground like a ragdoll until you die."
        return "death"
      end
    elsif choice.include?("safe") && @@inventory.include?("money")
      puts "You already emptied out the safe, there's nothing more to take.\n"
      enter
    elsif choice.include?("safe") && !@@inventory.include?("money")
      safe_opened = self.safe_crack
      @@tried_safe = true
      if safe_opened
        puts "You guessed the correct combination! You open up the safe and"
        puts "take out all of the money. This is the most cash you've ever"
        puts "seen in your life! You place the money in a trashbag and sling"
        puts "it over your shoulder."
        puts ""
        puts "It's a shame that your co-workers got mysteriously slaughtered."
        puts "You feel slightly bad about it, but then you think about all"
        puts "that beautiful money you just stole and you feel less bad."
        puts "You've got no time to mourn, you're rich now!"
        @@inventory.push("money")
        enter
      else
        enter
      end 
    else
      puts "You #{choice} and it kills you"
      return "death"       
    end
  end

  def safe_crack()
    is_safe_open = false
    last_digit = rand(10)
    puts "This is last digit: #{last_digit} for testing purposes"
    while (!is_safe_open)
      print "Enter the 4 digit code to open the safe: "
      safe_code = $stdin.gets.chomp
      if safe_code == "138" + last_digit.to_s
        is_safe_open = true
      else
        puts "You have entered an incorrect code"
        print "Would you like to try to re-enter the code? y or n? "
        re_enter_code = $stdin.gets.chomp
        if re_enter_code == 'y'
          next
        elsif re_enter_code == 'n'
          break
        else
          next
        end
      end
    end
    return is_safe_open
  end  

  def dynamic_intro()
    # returns the correct intro text based on state of tried_safe and 
    # inventory
      
    # default text for option 2 of dynamic intro
    option2 = "2. Head south out the back door and forget about all the blood 
and guts. Forget about the money in the safe. Just quietly leave out the back
door, jump on your mountain bike, and ride home to your apartment through the 
trail in the woods behind Grunge Taco."

    # default text for option 3 of dynamic intro
    option3 = "3. Try to open the safe by guessing the last number of the 4
digit pin code and get rich quick after stealing all that Grunge Taco money.
With all the blood, hostages, and deep fried severed hands, no one is going to
suspect you stole the money out of the safe. They will just add an additional
theft charge to whoever destroyed the place while you were sleeping."

    # this is the default configuration
    if !@@inventory.include?("money") && !@@tried_safe
      intro_text = "You enter the Grunge Taco kitchen. There's blood splattered
everywhere. There's blood in the sour cream station, blood on the Grunge Taco 
take-out bags, and there appears to be a severed human hand in the deep fryer 
basket. 

How did you manage to sleep through this masacre? You wonder to yourself. 

At this point you just want to go home. This is too much to handle. You should
be paid way more than minimum wage to deal with this type of stuff. As you look
around the room at all the blood and guts mixed with taco ingredients your eyes
land on the Grunge Taco safe. It's friday and there's a whole weeks worth of
money in that safe. Usually you aren't allowed to touch the safe. You are only
the assistant manager. The manager, Phil, who may not even still be alive is
the only one who has full access to the safe. But Phil has a habit of thinking
out loud. You've heard him mumbling the 4 digit pin number but you are only
sure of the first three numbers. 1 3 8. You were never able to make out the
last number."

    elsif !@@inventory.include?("money") && @@tried_safe
      introText = "You are still in the Grunge Taco kitchen."

      option3 = "3. Try to open the safe again" + option3[23..-1]

    
    elsif @@inventory.include?("money")
      introText = "You are still in the Grunge Taco kitchen. But now you are 
rich!"

      option2 = option2[0..71] + option2[108..-2] + " and spend the rest of the night counting all your money!"

      option3 = ""
    end

    # this is the outline for the dynamic intro
    dynamic_intro = "#{intro_text}
You need to decide your next move. You only have a few options:

1. Head north and go back into the Grunge Taco lobby, pour yourself a large
orange soda from the soda machine, and wait for the police to show up and sort
out this mess. You are technically still on the clock so you might as get paid to
chill out rather than punch out and go home.

#{option2}

#{option3}"

    return dynamic_intro
  end
end

class Lobby < Scene

  def enter()
    puts "You exit the restroom and enter the main lobby area of Grunge Taco."
    puts "Someone has blacked out all the windows with industrial strength" 
    puts "garbage bags and duct tape. With this new set-up, you can't see"
    puts "out, and no one can see in." 
    puts ""
    puts "You see two of your co-workers, Ray-Ray and Deshaun, blindfolded" 
    puts "and tied to the soda-fountain machine. They both appear to have" 
    puts "blood stains on their Grunge Taco uniforms. To the east is the exit"
    puts "to the front parking lot, to the south is the Grunge Taco kitchen" 
    puts "area, To the north is the Grunge taco Restroom that you just came"
    puts "out of." 
    puts ""
    puts "This situation seems to be getting weirder by the moment." 
    puts "You try to plan your next move. You don't have many options:"
    puts ""
    puts "1. Head north, go back into the restroom, and go back to sleep. You"
    puts "can just go hide and hope that everything will work itself out while"
    puts "you catch some zzzz's"
    puts ""
    puts "2. Head east, go outside through the front door, get on your bike,"
    puts "ride home, and start applying for a new job. It sure would be nice"
    puts "to have a job that involved less blood and less hostages than your"
    puts "current place of employment."
    puts ""
    puts "3. Head south into the Grunge Taco kitchen to further assess the" 
    puts "situation."
    puts ""
    puts "4. Untie Deshaun and Ray-Ray. Maybe they can fill you in on what has"
    puts " happened and help you save the day."

    print "> "
    choice = $stdin.gets.chomp

    if choice.include?("north") || choice.include?("restroom")
      puts "You decide that this situation is way out of the realm of your"
      puts "job discription and pay grade. You go back into the restroom to"
      puts "hide in the handicapped stall and sleep."
      puts ""
      puts "You figure that this will all just blow over. It's best not to get"
      puts "involved."
      puts ""
      puts "You open the door to the stall and lay down. You close your eyes"
      puts "and are about to catch some ZZZZ's when all of a sudden you hear a"
      puts "faint creaking noise. You try to ignore it but it keeps getting"
      puts "louder." 
      puts ""
      puts "You open your eyes to see what's causing this loud racket. You"
      puts "look up and see that the restroom's drop ceiling appears to be"
      puts "moving. The next thing you know the ceiling breaks open and a"
      puts "large fat man, wearing a nothing but a Hawaiian Lei and grass"
      puts "skirt, falls on top of you killing you instantly."
      return "death"
    elsif choice.include?("east") || choice.include?("outside")
      puts "You decide you've had enough of Grunge Taco."
      puts ""
      puts "\"I Quit!\" you yell out loud to no one in particular." 
      puts ""
      puts "It feels good to say those words. You feel reborn. You feel free."
      puts "Nothing is going to stop you now! You're gonna do it!"
      puts ""
      puts "You march out the front door into the Grunge Taco parking lot."
      puts "Everything is going to be better from now on. You start walking to"
      puts "go get your bike from the back alleyway. As you are walking you"
      puts "notice a small red dot on your chest. You try to flick it off but"
      puts "it won't budge. Suddenly, about a dozen more tiny red dots appear"
      puts "on your body." 
      puts ""
      puts "You look around and see that an entire S.W.A.T. team has you"
      puts "surrounded. The S.W.A.T. team's trained snipers are all pointing"
      puts "their riffles right at you."
      puts ""
      puts "You try to say \"What's this all about? Why are you pointing guns"
      puts "at me?\""
      puts ""
      puts "But you only are able to utter the syllable \"Wha...\" before you"
      puts "are shot to death about 50 times."
      return "death"
    elsif choice.include?("south") || choice.include?("kitchen")
      return "kitchen"
    elsif choice.include?"untie"
      puts "You decide to help Ray-Ray and Deshaun. Hopefully they will be"
      puts "able to explain what happened while you were sleeping in the"
      puts "restroom. You quickly untie both of them and remove their"
      puts "blindfolds." 
      puts ""
      puts "\"Guys, why are you tied up? Why is there blood splattered" 
      puts "everywhere?\" You ask."
      puts ""
      puts "\"What you mean who tied us up?\" Says Ray-Ray"
      puts ""
      puts "\"You the fool who tied us up! And now we gonna kill you!\""
      puts "says Deshaun."
      puts ""
      puts "You try to protest but neither of the men will listen to you. They"
      puts "are completely convinced that you are the one who tied them up."
      puts "You try to fight back but they overpower you and tie you to the"
      puts "soda-fountain machine. They then leave you and head into the"
      puts "kitchen."
      puts ""
      puts "You decide to just remain calm. The police will eventually show up"
      puts "and sort this whole thing out. The Grunge Taco surveillance camera"
      puts "footage will show everyone that you were in the restroom the whole"
      puts "time. It will prove your innocence to Ray-Ray and Deshaun and you"
      puts "will all have a nice big laugh about it all. So you just chill out"
      puts "and try to get comfortable while you wait." 
      puts ""
      puts "Ray-Ray and Deshaun soon emerge from the kitchen. Ray-Ray has a"
      puts "large plastic funnel. Deshaun has a roll of duct tape."
      puts ""
      puts "\"Hey guys... what are you going to do with that stuff?\" you"
      puts "nervously ask." 
      puts ""
      puts "Neither one of them utters a word. They begin duct tapping the"
      puts "funnel to your mouth. Next they position you under the orange soda"
      puts "dispenser on the soda fountain."
      puts ""
      puts "Deshaun uses some duct tape to keep the orange soda flowing into"
      puts "the funnel and down your throat. The two men exit the building and"
      puts "leave you to die."
      puts ""
      puts "Death by drowning."
      puts ""
      puts "Death by Orange Soda."
      return "death"
    else
      puts "You decide to #{choice}. You\'ve always been good at" 
      puts "#{choice}-ing. So you just #{choice} over and over. Suddenly you"
      puts "feel a sharp shooting pain in your abdomin. You must have"
      puts "#{choice}-ed to hard this time. You double over in excruciating"
      puts "pain. You then die on the floorof the Grunge Taco lobby."
      puts ""
      puts "Next time, if there is a next time, you might want to only"
      puts "#{choice} in moderation."
      return "death"
    end

  end
end

class Restroom < Scene

  def enter()
    puts "You wake up in the handicapped restroom stall of Grunge Taco."
    puts "Grunge Taco is a 1990's themed fast food restaurant chain. You work"
    puts "here as the assistant manager. This large handicapped stall is a"
    puts "perfect hiding place to avoid work and to take naps. You've taken" 
    puts "many naps in this stall. Waking up in here is not very unusual." 
    puts "What is unusual is that when you exit the stall you see what" 
    puts "appears to be blood splattered all over the walls, floor, and"
    puts "ceiling."
    puts ""
    puts "You quickly look around the room and try to plan your next move."
    puts "You don't have many options."
    puts "You can either:"
    puts ""
    puts "1. Go back in the stall, go back to sleep, and hope this is all" 
    puts "just a bad dream or some sort weird hallucination caused by the"
    puts "Grunge Taco MUCHO EXTREME-O Burrito you ate for lunch."
    puts ""
    puts "2. Search the restroom storage closet for something to protect" 
    puts "yourself with."
    puts ""
    puts "3. Leave the restroom and go into the restaurant lobby area."
    puts "Hopefully one of your co-workers will be there and will be able to"
    puts "explain why the restroom is covered in blood."

    print "> "
    choice = $stdin.gets.chomp

    if choice.include? "stall"
      puts "You decide the best course of action in this situation is no"
      puts "action at all. You retreat back to your bathroom stall hideaway."
      puts "You lay down on the floor of the stall and close your eyes. This"
      puts "is all just a bad dream. When you wake up everything will be back"
      puts "to normal. You start to doze off. Suddenly you hear a loud"
      puts "explosion. You open your eyes and the last thing you see is"
      puts "blindingly bright white light." 
      puts ""
      puts "What happened? Did a bomb go off?" 
      puts "Whatever happened killed you so at this point the fact that you"
      puts "are dead is preventing you from doing any indepth analysis or"
      puts "further investigation of the matter."
      return "death"

    elsif choice.include? "closet"
      puts "Action movies have taught you that if you ever find yourself in a"
      puts "crazy situation, like waking up in a blood-splattered fast food"
      puts "restroom, the first thing you should do is arm yourself with some"
      puts "kind of ridiculous handmade weapon fashioned from random objects"
      puts "in your immediate surroundings."
      puts ""
      puts "You begin to imagine yourself building a poisonous blow dart"
      puts "device out of cardboard toilet paper tubes, bristles from a toilet"
      puts "scrubber brush, and the mysterious \"blue\" brand of Grunge Taco"
      puts "all-purpose cleaner." 
      puts "You are sure that the restroom storage closet will give you all"
      puts "you need to become an action hero and save the day." 
      puts ""
      puts "You open the door to the closet with your employee key. It is"
      puts "completely dark inside the closet. As you are fumbling around for"
      puts "the light switch you suddenly feel a stabbing pain in your"
      puts "stomach. You flip the light on and see that you have been stabbed"
      puts "with a plastic spork that has been sharpenend into a" 
      puts "primative spear."
      puts ""
      puts "The person who stabbed you is your co-worker Traynesha. As you"
      puts "bleed to death in excrutiating pain you manage to utter the word" 
      puts "\"WHY??\". Traynesha says nothing and then stabs you a second"
      puts "time, this time in the jugular." 
      puts "You quickly bleed to death and die."
      return "death"

    elsif choice.include? "leave"
      return "lobby"
    else 
      puts "You try to #{choice} and that seems to be the right choice. You"
      puts "just keep #{choice}-ing and #{choice}-ing. You never realized how"
      puts "wonderful #{choice}-ing could be."
      puts "But then suddenly you develop a deadly allergy to #{choice}. You"
      puts "try to scream but your throat closes up. You try to dial 911 but"
      puts "your phone battery is dead from all the #{choice}-ing you were"
      puts "doing. You soon die from acute #{choice} poisoning." 
      return "death"
    end
  end

end

class Engine

   def initialize(scene_map)
     @scene_map = scene_map
   end

   def play()
     current_scene = @scene_map.opening_scene()
     last_scene = @scene_map.next_scene('finished')

     while current_scene != last_scene
       next_scene_name = current_scene.enter()
       current_scene = @scene_map.next_scene(next_scene_name)
     end

     # prints out the last scene
     current_scene.enter()
   end
end

class Map

  @@scenes = {
    'restroom' => Restroom.new(),
    'lobby' => Lobby.new(),
    'kitchen' => Kitchen.new(),
    'death' => Death.new(),
    'finished' => Finished.new()
  } 
    
  def initialize(start_scene)
    @start_scene = start_scene
  end

  def next_scene(scene_name)
    val = @@scenes[scene_name]
    return val
  end

  def opening_scene()
    return next_scene(@start_scene)
  end
end

a_map = Map.new('restroom')
a_game = Engine.new(a_map)
a_game.play()
