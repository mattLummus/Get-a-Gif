Get-a-Gif User Stories
---------------------------

As a social media user, in order to communicate using images I want to quickly and easily find relevant .gif urls

## Using the Menu
As someone that's unfamiliar with the application
I want to see a list of options
So that I can continue on

#### Acceptance Criteria:
  * If the user selects 1, they see "What is your first criteria? 1. Category 2. Emotion 3. Reference 4. Random Sample"
  * If the user selects 2, they see "Enter your url:"
  * If the user types in anything else, they should see "<input> is an invalid selection" and the menu should be printed out again

Usage:

    > ./living_will_to_die
    What do you want to do?
    1. Get a .gif
    2. Give a .gif

### Get a .gif (DB query)

As someone wanting to use a .gif I liked and stored for use in social media
without having to browse images or undescriptive url's, 
I want to find a relevant .gif url
quickly through a guided process

Acceptance Criteria:

  * Users can specifiy which tag they would like to start with
  * They can also opt for a random sample
  * If less than 5 gifs exist for any given tag the menu stops there and gives all relevant urls
  * When the app finds urls to give to the user it does so by opening their link in the Chrome browser

Usage:

    > ./living_will_to_die
    What do you want to do?
    1. Get a .gif
    2. Give a .gif
    - 1
    What is your first criteria?
    1. Category
    2. Emotion
    3. Reference
    - 1
    4. Random Sample
    What Category?
    1. Reaction
    2. Abstract
    3. New Category
    - 1
    What Emotion?
    1. Approval
    2. Excitement
    3. Anger/Frustration
    4. Happiness
    5. Skepticism
    6. Sarcasm
    7. New Emotion
    - 1
    What Reference?
    1. Meme
    2. Batman
    3. Generic
    4. New Reference
    - 2

### Give a .gif (DB insert)

As someone wanting to store gifs I like for easy and relevant retrieval
I want to insert a .gif url with appropriate tags
quickly through a guided process

Acceptance Criteria:

  * Unique url's will be added to the database
  * Duplicate url's can't be added
  * Tagging is done with a category, emotion, and reference
  * Users are prompted with exisiting tags but can also enter a new category

Usage:

    > ./living_will_to_die
    What do you want to do?
    1. Get a .gif
    2. Give a .gif
    - 2
    Enter your url:
    - https://i.imgur.com/LsglmGb.gif
    What Category?
    1. Reaction
    2. Abstract
    3. New Category
    - 1
    What Emotion?
    1. Approval
    2. Excitement
    3. Anger/Frustration
    4. Happiness
    5. Skepticism
    6. Sarcasm
    7. New Emotion
    - 1
    What Reference?
    1. Meme
    2. Batman
    3. Generic
    4. New Reference
    - 2
