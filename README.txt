README:
CPSC312

EPIC Text Adventure!
based on a true story.

Created by:

Riley Chang          41805086    l1v6
Hanna Yoo            65434086    e9t6
Rob MacEachern       42415091    m9c7


We created a text adventure game called “EPIC Text Adventure”. From the game introduction:

“Your goal as a CS student is to complete a Prolog project and get an A+.

You, of course, needed a challenge and so chose to undertake building a scheduler that would be the envy of the entire class!

You did not foresee the difficulties however, and are having quite a bit of trouble.

With not much time left, you desperately explore your world searching for any hints you can find so you can "write code" that will work.

How much advice do you need? Who knows? Better start hunting!”

Solution Path:
Start game by consulting epicTextAdventure then type 'play.'.
    pick up flowers.
    go to lab.
    seduce TA with flowers
    pick up id.
    go to bar.
    pick up iphone.
    drink some beer with fake id
    punch the popo.
        - (before you get money) bribe jailer
        - LOSE
    punch prisoner.
    cry to jailer.
    bribe jailer with money
    go to lab.
    blackmail kim with iphone
        -(second time) blackmail kim
        -LOSE
    write code.
    WIN!

Undesirable responses:
1) Grammar: When trying to interact with someone not at your location it responds:
        “X is not here.”
        This works fine for “Kim is not here.” but is ungrammatical for all the other
	persons.
2) Grammar: If attempt to seduce the ta with just one flower: “seduce the ta with a flower” the

response says we used “flowers” and removes the whole collection of flowers.


Note these additional CAVEATS of the game:
3) If you have flowers then you can seduce anyone other than TA (which you need to in order to win the game). This ends up using the flowers for someone else, so player is guaranteed to lose.  The same can be said for the money (bribing characters other than the ones necessary).   The game can be ended manually tho or the player can continue the game until they do one of the above.


Cool zone!

    Made by cool people!
    Played by cool people!
    Cool ascii logo!
    It’s based on a true story! (minus blackmailing kim, punching the prisoner, or even going to the lab the rest who knows?):
    You can punch your mom!

Note: We had initially started implementing a scheduling application instead of text adventure game. The main goal of the scheduler was to determine if and when two or more people were available to meet based on the availability supplied to the program. Unfortunately we were unable to determine a way to structure and query a knowledge base for the information we desired, so with time running down we switched our focus to the EPIC Text Adventure instead. We’ve included our work on scheduler in a separate directory. A few highlights:

    Parses google calendar XML file.
    Using the sgml library, we were able to extract calendar event details such as:
    “Mon 12 Dec 2011 12:00 to 15:00”
	- The plan was to use these entries to populate our knowledge base.
    Conversion of string dates to timestamps
    Able to understand complex grammars (including recursive conjunctions!):
	- When can x and z meet?
	- x and y are busy on <day>.
	- Are x and y and z busy on <day> from <time> to <time>?
	
So really we did like 1.5 projects! That’s pretty cool! ;)
